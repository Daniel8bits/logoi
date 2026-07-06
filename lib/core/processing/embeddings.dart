import 'dart:math';
import 'dart:typed_data';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database/daos/document_dao.dart';
import '../database/database.dart';
import '../services/ollama_service.dart';

/// Serializes embedding vectors as float32 blobs (docs/03_DATABASE.md §3.5).
abstract final class EmbeddingCodec {
  static Uint8List encode(List<double> vector) =>
      Float32List.fromList(vector).buffer.asUint8List();

  static Float32List decode(Uint8List bytes) =>
      bytes.buffer.asFloat32List(bytes.offsetInBytes, bytes.lengthInBytes ~/ 4);
}

double cosineSimilarity(List<double> a, List<double> b) {
  if (a.isEmpty || a.length != b.length) return 0;
  var dot = 0.0, normA = 0.0, normB = 0.0;
  for (var i = 0; i < a.length; i++) {
    dot += a[i] * b[i];
    normA += a[i] * a[i];
    normB += b[i] * b[i];
  }
  if (normA == 0 || normB == 0) return 0;
  return dot / (sqrt(normA) * sqrt(normB));
}

/// Stage 3 of the import pipeline (docs/05_PROCESSING.md §3): generates
/// paragraph embeddings via Ollama. Idempotent — only missing paragraphs
/// are embedded. When Ollama is offline the document stays `segmented`
/// and semantic search remains disabled (§3.1).
class EmbeddingIndexer {
  EmbeddingIndexer({
    required DocumentDao documentDao,
    required OllamaService ollama,
  })  : _documentDao = documentDao,
        _ollama = ollama;

  final DocumentDao _documentDao;
  final OllamaService _ollama;

  static const _uuid = Uuid();
  static const _insertBatchSize = 16;

  /// Statuses beyond `indexed` must never be regressed by re-indexing.
  static const _advancedStatuses = {'summarized', 'fully_processed'};

  /// Returns false when Ollama is (or becomes) unavailable.
  Future<bool> indexDocument(
    String documentId, {
    void Function(int done, int total)? onProgress,
  }) async {
    if (!await _ollama.isAvailable()) return false;

    final pending =
        await _documentDao.getParagraphsWithoutEmbeddings(documentId);
    if (pending.isEmpty) {
      await _setStatus(documentId, 'indexed');
      return true;
    }

    await _setStatus(documentId, 'indexing');
    final buffer = <ParagraphEmbeddingsCompanion>[];
    var done = 0;
    for (final paragraph in pending) {
      final vector = await _ollama.embed(paragraph.content);
      if (vector == null) {
        // Ollama went offline midway; keep what was persisted so far.
        await _setStatus(documentId, 'segmented');
        return false;
      }
      buffer.add(ParagraphEmbeddingsCompanion(
        id: Value(_uuid.v4()),
        paragraphId: Value(paragraph.id),
        embedding: Value(EmbeddingCodec.encode(vector)),
        model: const Value(OllamaService.defaultEmbeddingModel),
        dimensions: Value(vector.length),
        createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      ));
      if (buffer.length >= _insertBatchSize) {
        await _documentDao.insertEmbeddings(List.of(buffer));
        buffer.clear();
      }
      onProgress?.call(++done, pending.length);
    }
    if (buffer.isNotEmpty) await _documentDao.insertEmbeddings(buffer);
    await _setStatus(documentId, 'indexed');
    return true;
  }

  Future<void> _setStatus(String documentId, String status) async {
    final doc = await _documentDao.getById(documentId);
    if (doc == null || _advancedStatuses.contains(doc.processingStatus)) {
      return;
    }
    await _documentDao.setProcessingStatus(documentId, status);
  }
}
