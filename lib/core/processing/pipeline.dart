import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database/daos/document_dao.dart';
import '../database/database.dart';
import '../pdf/extractor.dart';
import '../pdf/segmenter.dart';
import '../pdf/structure.dart';

/// Import pipeline orchestrator (docs/05_PROCESSING.md §3).
///
/// Stage 1 (deterministic): text + TOC extraction → status `imported`.
/// Stage 2 (heuristic): paragraph segmentation + structure → `segmented`.
/// Stages 3-5 (embeddings/summaries) run lazily in later phases.
/// Every stage persists results, so interruptions never require
/// reprocessing; stages are idempotent.
class ImportPipeline {
  ImportPipeline({
    required DocumentDao documentDao,
    PdfExtractor extractor = const PdfExtractor(),
    TextSegmenter segmenter = const TextSegmenter(),
    StructureBuilder structureBuilder = const StructureBuilder(),
  })  : _documentDao = documentDao,
        _extractor = extractor,
        _segmenter = segmenter,
        _structureBuilder = structureBuilder;

  final DocumentDao _documentDao;
  final PdfExtractor _extractor;
  final TextSegmenter _segmenter;
  final StructureBuilder _structureBuilder;

  static const _uuid = Uuid();

  /// Runs stages 1-2 for a newly imported document.
  /// Returns the extracted document (for immediate UI use).
  Future<ExtractedDocument> run({
    required String documentId,
    required String filePath,
    void Function(String status)? onStatus,
  }) async {
    // Stage 1 — deterministic extraction.
    onStatus?.call('extracting');
    final extracted = await _extractor.extract(filePath);

    await _documentDao.insertPages([
      for (final entry in extracted.pageTexts.entries)
        PageContentsCompanion(
          id: Value(_uuid.v4()),
          documentId: Value(documentId),
          pageNumber: Value(entry.key),
          content: Value(entry.value),
        ),
    ]);
    await _documentDao.updateDocument(
      documentId,
      DocumentsCompanion(
        totalPages: Value(extracted.totalPages),
        title: Value.absentIfNull(extracted.title),
        year: Value.absentIfNull(extracted.year),
        processingStatus: const Value('imported'),
      ),
    );

    // Stage 2 — heuristic segmentation + structure.
    onStatus?.call('segmenting');
    final paragraphEntries = <ParagraphsCompanion>[];
    for (final entry in extracted.pageTexts.entries) {
      final paragraphs = _segmenter.segmentParagraphs(entry.value);
      for (var i = 0; i < paragraphs.length; i++) {
        paragraphEntries.add(ParagraphsCompanion(
          id: Value(_uuid.v4()),
          documentId: Value(documentId),
          pageNumber: Value(entry.key),
          paragraphIndex: Value(i),
          content: Value(paragraphs[i]),
        ));
      }
    }
    await _documentDao.insertParagraphs(paragraphEntries);

    final nodes = _structureBuilder.build(extracted.toc, extracted.totalPages);
    final nodeIds = List.generate(nodes.length, (_) => _uuid.v4());
    await _documentDao.insertStructure([
      for (var i = 0; i < nodes.length; i++)
        DocumentStructureCompanion(
          id: Value(nodeIds[i]),
          documentId: Value(documentId),
          parentId: Value(
            nodes[i].parentIndex != null ? nodeIds[nodes[i].parentIndex!] : null,
          ),
          level: Value(nodes[i].level),
          title: Value(nodes[i].title),
          pageStart: Value(nodes[i].pageStart),
          pageEnd: Value(nodes[i].pageEnd),
          orderIndex: Value(nodes[i].orderIndex),
        ),
    ]);

    await _documentDao.setProcessingStatus(documentId, 'segmented');
    onStatus?.call('segmented');
    return extracted;
  }
}
