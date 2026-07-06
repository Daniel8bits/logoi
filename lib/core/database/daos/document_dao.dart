import 'dart:typed_data';

import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/document_tables.dart';

part 'document_dao.drift.dart';

/// A paragraph joined with its stored embedding blob, for local
/// similarity search (docs/05_PROCESSING.md §6.1).
class EmbeddedParagraph {
  const EmbeddedParagraph({required this.paragraph, required this.embedding});

  final ParagraphRow paragraph;
  final Uint8List embedding;
}

@DriftAccessor(
  tables: [
    Documents,
    PageContents,
    Paragraphs,
    ParagraphEmbeddings,
    DocumentStructure,
    SectionSummaries,
    ReadingSessions,
  ],
)
class DocumentDao extends DatabaseAccessor<LogoiDatabase>
    with _$DocumentDaoMixin {
  DocumentDao(super.db);

  // ── Documents ──

  Future<List<DocumentRow>> getByProject(String projectId) =>
      (select(documents)
            ..where((t) => t.projectId.equals(projectId))
            ..orderBy([(t) => OrderingTerm.desc(t.importedAt)]))
          .get();

  Stream<List<DocumentRow>> watchByProject(String projectId) =>
      (select(documents)
            ..where((t) => t.projectId.equals(projectId))
            ..orderBy([(t) => OrderingTerm.desc(t.importedAt)]))
          .watch();

  Future<DocumentRow?> getById(String id) =>
      (select(documents)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<DocumentRow?> watchById(String id) =>
      (select(documents)..where((t) => t.id.equals(id))).watchSingleOrNull();

  Future<void> insertDocument(DocumentsCompanion entry) =>
      into(documents).insert(entry);

  Future<void> updateDocument(String id, DocumentsCompanion entry) =>
      (update(documents)..where((t) => t.id.equals(id))).write(entry);

  Future<void> deleteDocument(String id) =>
      (delete(documents)..where((t) => t.id.equals(id))).go();

  Future<void> setProcessingStatus(String id, String status) =>
      updateDocument(id, DocumentsCompanion(processingStatus: Value(status)));

  Future<void> setLastReadPage(String id, int page) =>
      updateDocument(id, DocumentsCompanion(lastReadPage: Value(page)));

  // ── Page contents ──

  Future<void> insertPages(List<PageContentsCompanion> entries) =>
      batch((b) => b.insertAll(pageContents, entries, mode: InsertMode.insertOrReplace));

  Future<List<PageContentRow>> getPages(String documentId) =>
      (select(pageContents)
            ..where((t) => t.documentId.equals(documentId))
            ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]))
          .get();

  Future<PageContentRow?> getPage(String documentId, int pageNumber) =>
      (select(pageContents)
            ..where((t) =>
                t.documentId.equals(documentId) & t.pageNumber.equals(pageNumber)))
          .getSingleOrNull();

  // ── Paragraphs ──

  Future<void> insertParagraphs(List<ParagraphsCompanion> entries) =>
      batch((b) => b.insertAll(paragraphs, entries, mode: InsertMode.insertOrReplace));

  Future<List<ParagraphRow>> getParagraphs(String documentId, {int? pageNumber}) {
    final query = select(paragraphs)
      ..where((t) => t.documentId.equals(documentId))
      ..orderBy([
        (t) => OrderingTerm.asc(t.pageNumber),
        (t) => OrderingTerm.asc(t.paragraphIndex),
      ]);
    if (pageNumber != null) {
      query.where((t) => t.pageNumber.equals(pageNumber));
    }
    return query.get();
  }

  Future<void> setCompressedText(String paragraphId, String compressed) =>
      (update(paragraphs)..where((t) => t.id.equals(paragraphId)))
          .write(ParagraphsCompanion(compressedText: Value(compressed)));

  // ── Embeddings (docs/05_PROCESSING.md §3 etapa 3) ──

  Future<List<ParagraphRow>> getParagraphsWithoutEmbeddings(
    String documentId,
  ) =>
      (select(paragraphs)
            ..where((t) =>
                t.documentId.equals(documentId) &
                notExistsQuery(select(paragraphEmbeddings)
                  ..where((e) => e.paragraphId.equalsExp(t.id))))
            ..orderBy([
              (t) => OrderingTerm.asc(t.pageNumber),
              (t) => OrderingTerm.asc(t.paragraphIndex),
            ]))
          .get();

  Future<void> insertEmbeddings(List<ParagraphEmbeddingsCompanion> entries) =>
      batch((b) => b.insertAll(paragraphEmbeddings, entries,
          mode: InsertMode.insertOrReplace));

  Future<List<EmbeddedParagraph>> getEmbeddedParagraphs({
    String? documentId,
  }) async {
    final query = select(paragraphs).join([
      innerJoin(
        paragraphEmbeddings,
        paragraphEmbeddings.paragraphId.equalsExp(paragraphs.id),
      ),
    ]);
    if (documentId != null) {
      query.where(paragraphs.documentId.equals(documentId));
    }
    final rows = await query.get();
    return [
      for (final row in rows)
        EmbeddedParagraph(
          paragraph: row.readTable(paragraphs),
          embedding: row.readTable(paragraphEmbeddings).embedding,
        ),
    ];
  }

  // ── Section summaries (docs/05_PROCESSING.md §5) ──

  Future<SectionSummaryRow?> getSummaryForStructure(String structureId) =>
      (select(sectionSummaries)
            ..where((t) => t.structureId.equals(structureId))
            ..limit(1))
          .getSingleOrNull();

  Future<List<SectionSummaryRow>> getSummariesForDocument(
    String documentId,
  ) async {
    final query = select(sectionSummaries).join([
      innerJoin(
        documentStructure,
        documentStructure.id.equalsExp(sectionSummaries.structureId),
        useColumns: false,
      ),
    ])
      ..where(documentStructure.documentId.equals(documentId));
    final rows = await query.get();
    return [for (final row in rows) row.readTable(sectionSummaries)];
  }

  /// Idempotent: replaces any previous summary of the same structure node.
  Future<void> upsertSectionSummary(SectionSummariesCompanion entry) =>
      transaction(() async {
        await (delete(sectionSummaries)
              ..where((t) => t.structureId.equals(entry.structureId.value)))
            .go();
        await into(sectionSummaries).insert(entry);
      });

  Future<void> setStructureStatus(String structureId, String status) =>
      (update(documentStructure)..where((t) => t.id.equals(structureId)))
          .write(DocumentStructureCompanion(processingStatus: Value(status)));

  // ── Structure ──

  Future<void> insertStructure(List<DocumentStructureCompanion> entries) =>
      batch((b) =>
          b.insertAll(documentStructure, entries, mode: InsertMode.insertOrReplace));

  Future<List<StructureRow>> getStructure(String documentId) =>
      (select(documentStructure)
            ..where((t) => t.documentId.equals(documentId))
            ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
          .get();

  // ── Reading sessions ──

  Future<void> insertReadingSession(ReadingSessionsCompanion entry) =>
      into(readingSessions).insert(entry);

  Future<void> endReadingSession(String id, int endPage, int durationS) =>
      (update(readingSessions)..where((t) => t.id.equals(id))).write(
        ReadingSessionsCompanion(
          endPage: Value(endPage),
          durationS: Value(durationS),
          endedAt: Value(DateTime.now().millisecondsSinceEpoch),
        ),
      );

  /// Closes sessions left open (started > 4h ago). See docs/03_DATABASE.md §3.19.
  Future<void> cleanupOrphanSessions() async {
    final cutoff = DateTime.now()
        .subtract(const Duration(hours: 4))
        .millisecondsSinceEpoch;
    await (update(readingSessions)
          ..where((t) => t.endedAt.isNull() & t.startedAt.isSmallerThanValue(cutoff)))
        .write(ReadingSessionsCompanion(
      endedAt: Value(DateTime.now().millisecondsSinceEpoch),
    ));
  }

  Future<List<ReadingSessionRow>> getReadingSessions(String documentId) =>
      (select(readingSessions)
            ..where((t) => t.documentId.equals(documentId))
            ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
          .get();
}
