import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/annotation_tables.dart';

part 'annotation_dao.drift.dart';

@DriftAccessor(tables: [Annotations, AnnotationVersions, Notebooks])
class AnnotationDao extends DatabaseAccessor<LogoiDatabase>
    with _$AnnotationDaoMixin {
  AnnotationDao(super.db);

  // ── Annotations ──

  Stream<List<AnnotationRow>> watchByDocument(String documentId) =>
      (select(annotations)
            ..where((t) => t.documentId.equals(documentId))
            ..orderBy([
              (t) => OrderingTerm.asc(t.pageNumber),
              (t) => OrderingTerm.asc(t.createdAt),
            ]))
          .watch();

  Future<List<AnnotationRow>> getByDocument(String documentId) =>
      (select(annotations)
            ..where((t) => t.documentId.equals(documentId))
            ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]))
          .get();

  Future<List<AnnotationRow>> getByPage(String documentId, int pageNumber) =>
      (select(annotations)
            ..where((t) =>
                t.documentId.equals(documentId) & t.pageNumber.equals(pageNumber)))
          .get();

  Future<AnnotationRow?> getById(String id) =>
      (select(annotations)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> insertAnnotation(AnnotationsCompanion entry) =>
      into(annotations).insert(entry);

  Future<void> updateAnnotation(String id, AnnotationsCompanion entry) =>
      (update(annotations)..where((t) => t.id.equals(id))).write(entry);

  Future<void> deleteAnnotation(String id) =>
      (delete(annotations)..where((t) => t.id.equals(id))).go();

  /// Pages with at least one annotation, for RAG reranking boosts
  /// (docs/05_PROCESSING.md §6.1).
  Future<Set<int>> getAnnotatedPages(String documentId) async {
    final query = selectOnly(annotations, distinct: true)
      ..addColumns([annotations.pageNumber])
      ..where(annotations.documentId.equals(documentId));
    final rows = await query.get();
    return {for (final row in rows) row.read(annotations.pageNumber)!};
  }

  // ── Versions ──

  Future<void> insertVersion(AnnotationVersionsCompanion entry) =>
      into(annotationVersions).insert(entry);

  Future<List<AnnotationVersionRow>> getVersions(String annotationId) =>
      (select(annotationVersions)
            ..where((t) => t.annotationId.equals(annotationId))
            ..orderBy([(t) => OrderingTerm.desc(t.changedAt)]))
          .get();

  Future<AnnotationVersionRow?> getLatestVersion(String annotationId) =>
      (select(annotationVersions)
            ..where((t) => t.annotationId.equals(annotationId))
            ..orderBy([(t) => OrderingTerm.desc(t.changedAt)])
            ..limit(1))
          .getSingleOrNull();

  // ── Notebooks ──

  Stream<List<NotebookRow>> watchByProject(String projectId) =>
      (select(notebooks)
            ..where((t) => t.projectId.equals(projectId))
            ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
          .watch();

  Future<NotebookRow?> getNotebookForDocument(String documentId) =>
      (select(notebooks)..where((t) => t.documentId.equals(documentId)))
          .getSingleOrNull();

  Future<void> insertNotebook(NotebooksCompanion entry) =>
      into(notebooks).insert(entry);

  Future<void> updateNotebook(String id, NotebooksCompanion entry) =>
      (update(notebooks)..where((t) => t.id.equals(id))).write(entry);

  Future<void> deleteNotebook(String id) =>
      (delete(notebooks)..where((t) => t.id.equals(id))).go();
}
