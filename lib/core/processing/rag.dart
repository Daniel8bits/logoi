import '../ai/models.dart';
import '../database/daos/document_dao.dart';
import '../database/daos/search_dao.dart';
import 'compressor.dart';
import 'semantic_search.dart';

/// Token budget for retrieved context (docs/05_PROCESSING.md §6.2).
class RAGContextBudget {
  static const int totalBudget = 6000;
  static const int systemPromptReserve = 800;
  static const int responseReserve = 1500;
  static const int historyReserve = 1200;
  static const int retrievedContextBudget = 2500;
}

/// Builds the retrieved context for on-demand AI features
/// (docs/05_PROCESSING.md §6.1).
///
/// With Ollama available, retrieval is semantic (cosine similarity over
/// paragraph embeddings) followed by reranking: boost for the current page
/// (+0.2), boost for annotated pages (+0.1) and penalty for chunks already
/// used in this chat session (-0.1). Without Ollama it falls back to FTS5
/// lexical retrieval plus current page ±2 (§6.3). Every chunk goes through
/// the deterministic TextCompressor before being sent to any API.
class RAGContextBuilder {
  RAGContextBuilder({
    required DocumentDao documentDao,
    required SearchDao searchDao,
    SemanticSearchService? semanticSearch,
    TextCompressor compressor = const TextCompressor(),
  })  : _documentDao = documentDao,
        _searchDao = searchDao,
        _semanticSearch = semanticSearch,
        _compressor = compressor;

  final DocumentDao _documentDao;
  final SearchDao _searchDao;
  final SemanticSearchService? _semanticSearch;
  final TextCompressor _compressor;

  static const _semanticTopK = 8;
  static const _currentPageBoost = 0.2;
  static const _annotatedBoost = 0.1;
  static const _repetitionPenalty = 0.1;

  Future<List<RAGChunk>> build({
    required String documentId,
    required int currentPage,
    String? query,
    Set<int> annotatedPages = const {},
    Set<int> penalizedPages = const {},
  }) async {
    final chunks = <RAGChunk>[];
    final windowPages = <int>{};

    // Current page ± 2 (page-window context).
    for (var page = currentPage - 2; page <= currentPage + 2; page++) {
      if (page < 1) continue;
      final content = await _documentDao.getPage(documentId, page);
      if (content == null) continue;
      windowPages.add(page);
      chunks.add(RAGChunk(
        text: _compressor.compress(content.content),
        pageNumber: page,
        similarity: _rerank(
          page == currentPage ? 1.0 : 0.5,
          page,
          currentPage,
          annotatedPages,
          penalizedPages,
        ),
        isCurrentPage: page == currentPage,
      ));
    }

    if (query != null && query.trim().isNotEmpty) {
      final retrieved = await _retrieve(query, documentId);
      for (final hit in retrieved) {
        if (windowPages.contains(hit.pageNumber)) continue;
        chunks.add(RAGChunk(
          text: _compressor.compress(hit.text),
          pageNumber: hit.pageNumber,
          similarity: _rerank(
            hit.baseScore,
            hit.pageNumber,
            currentPage,
            annotatedPages,
            penalizedPages,
          ),
        ));
      }
    }

    return _fitBudget(chunks);
  }

  Future<List<_RetrievedChunk>> _retrieve(
    String query,
    String documentId,
  ) async {
    final semanticHits = await _semanticSearch?.search(
      query,
      documentId: documentId,
      limit: _semanticTopK,
    );
    if (semanticHits != null && semanticHits.isNotEmpty) {
      return [
        for (final hit in semanticHits)
          _RetrievedChunk(
            text: hit.content,
            pageNumber: hit.pageNumber,
            baseScore: hit.score,
          ),
      ];
    }

    // FTS5 lexical fallback (docs/05_PROCESSING.md §6.3).
    final lexicalHits = await _searchDao.searchPages(
      query,
      documentId: documentId,
      limit: 5,
    );
    final chunks = <_RetrievedChunk>[];
    final seenPages = <int>{};
    for (final hit in lexicalHits) {
      if (!seenPages.add(hit.pageNumber)) continue;
      final content = await _documentDao.getPage(documentId, hit.pageNumber);
      if (content == null) continue;
      chunks.add(_RetrievedChunk(
        text: content.content,
        pageNumber: hit.pageNumber,
        baseScore: 0.4,
      ));
    }
    return chunks;
  }

  double _rerank(
    double base,
    int page,
    int currentPage,
    Set<int> annotatedPages,
    Set<int> penalizedPages,
  ) {
    var score = base;
    if (page == currentPage) score += _currentPageBoost;
    if (annotatedPages.contains(page)) score += _annotatedBoost;
    if (penalizedPages.contains(page)) score -= _repetitionPenalty;
    return score;
  }

  /// Truncates the least relevant chunks to fit the retrieved-context budget.
  List<RAGChunk> _fitBudget(List<RAGChunk> chunks) {
    final sorted = [...chunks]
      ..sort((a, b) => b.similarity.compareTo(a.similarity));
    final result = <RAGChunk>[];
    var tokens = 0;
    for (final chunk in sorted) {
      final chunkTokens = (chunk.text.length / 4).ceil();
      if (tokens + chunkTokens > RAGContextBudget.retrievedContextBudget) {
        final remaining = RAGContextBudget.retrievedContextBudget - tokens;
        if (remaining > 100) {
          result.add(RAGChunk(
            text: chunk.text.substring(0, remaining * 4),
            pageNumber: chunk.pageNumber,
            similarity: chunk.similarity,
            isCurrentPage: chunk.isCurrentPage,
          ));
        }
        break;
      }
      result.add(chunk);
      tokens += chunkTokens;
    }
    result.sort((a, b) => a.pageNumber.compareTo(b.pageNumber));
    return result;
  }
}

class _RetrievedChunk {
  const _RetrievedChunk({
    required this.text,
    required this.pageNumber,
    required this.baseScore,
  });

  final String text;
  final int pageNumber;
  final double baseScore;
}
