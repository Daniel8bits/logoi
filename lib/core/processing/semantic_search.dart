import '../database/daos/document_dao.dart';
import '../database/daos/search_dao.dart';
import '../services/ollama_service.dart';
import 'embeddings.dart';

/// A paragraph ranked by cosine similarity to the query.
class SemanticHit {
  const SemanticHit({
    required this.paragraphId,
    required this.documentId,
    required this.pageNumber,
    required this.content,
    required this.score,
  });

  final String paragraphId;
  final String documentId;
  final int pageNumber;
  final String content;
  final double score;
}

/// Local cosine-similarity search over stored paragraph embeddings
/// (docs/05_PROCESSING.md §6.1 — Nível 3, no API cost).
class SemanticSearchService {
  SemanticSearchService({
    required DocumentDao documentDao,
    required OllamaService ollama,
  })  : _documentDao = documentDao,
        _ollama = ollama;

  final DocumentDao _documentDao;
  final OllamaService _ollama;

  /// Returns null when Ollama is offline (callers fall back to FTS5,
  /// docs/05_PROCESSING.md §6.3).
  Future<List<SemanticHit>?> search(
    String query, {
    String? documentId,
    int limit = 10,
  }) async {
    final queryVector = await _ollama.embed(query);
    if (queryVector == null) return null;

    final embedded =
        await _documentDao.getEmbeddedParagraphs(documentId: documentId);
    final hits = <SemanticHit>[
      for (final entry in embedded)
        SemanticHit(
          paragraphId: entry.paragraph.id,
          documentId: entry.paragraph.documentId,
          pageNumber: entry.paragraph.pageNumber,
          content: entry.paragraph.content,
          score: cosineSimilarity(
            EmbeddingCodec.decode(entry.embedding),
            queryVector,
          ),
        ),
    ]..sort((a, b) => b.score.compareTo(a.score));
    return hits.take(limit).toList();
  }
}

/// A merged lexical + semantic result.
class HybridHit {
  const HybridHit({
    required this.documentId,
    required this.pageNumber,
    required this.excerpt,
    required this.score,
    required this.isSemantic,
  });

  final String documentId;
  final int pageNumber;
  final String excerpt;
  final double score;

  /// Whether the semantic component contributed to this hit.
  final bool isSemantic;
}

/// Hybrid search: FTS5 + semantic with weighted score
/// (docs/05_PROCESSING.md §6.4 — 0.35 lexical / 0.65 semantic).
class HybridSearchService {
  HybridSearchService({
    required SearchDao searchDao,
    required SemanticSearchService semantic,
  })  : _searchDao = searchDao,
        _semantic = semantic;

  final SearchDao _searchDao;
  final SemanticSearchService _semantic;

  static const lexicalWeight = 0.35;
  static const semanticWeight = 0.65;

  Future<List<HybridHit>> search(
    String query, {
    String? documentId,
    int limit = 20,
  }) async {
    final lexical = await _searchDao.searchPages(
      query,
      documentId: documentId,
      limit: limit,
    );
    final semantic =
        await _semantic.search(query, documentId: documentId, limit: limit);

    final accumulated = <String, _HybridAccumulator>{};

    // BM25 ranks have no fixed scale; use rank position as lexical score.
    for (var i = 0; i < lexical.length; i++) {
      final hit = lexical[i];
      final positional = 1 - i / lexical.length;
      accumulated
          .putIfAbsent(
            '${hit.documentId}:${hit.pageNumber}',
            () => _HybridAccumulator(
              documentId: hit.documentId,
              pageNumber: hit.pageNumber,
              excerpt: hit.snippet.replaceAll(RegExp('</?b>'), ''),
            ),
          )
          .score += (semantic == null ? 1.0 : lexicalWeight) * positional;
    }

    if (semantic != null) {
      for (final hit in semantic) {
        final entry = accumulated.putIfAbsent(
          '${hit.documentId}:${hit.pageNumber}',
          () => _HybridAccumulator(
            documentId: hit.documentId,
            pageNumber: hit.pageNumber,
            excerpt: _truncate(hit.content, 200),
          ),
        );
        entry.score += semanticWeight * hit.score;
        entry.isSemantic = true;
      }
    }

    final merged = accumulated.values.toList()
      ..sort((a, b) => b.score.compareTo(a.score));
    return [
      for (final entry in merged.take(limit))
        HybridHit(
          documentId: entry.documentId,
          pageNumber: entry.pageNumber,
          excerpt: entry.excerpt,
          score: entry.score,
          isSemantic: entry.isSemantic,
        ),
    ];
  }

  static String _truncate(String text, int max) =>
      text.length <= max ? text : '${text.substring(0, max)}…';
}

class _HybridAccumulator {
  _HybridAccumulator({
    required this.documentId,
    required this.pageNumber,
    required this.excerpt,
  });

  final String documentId;
  final int pageNumber;
  final String excerpt;
  double score = 0;
  bool isSemantic = false;
}
