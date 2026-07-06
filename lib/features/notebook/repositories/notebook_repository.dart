import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/daos/annotation_dao.dart';
import '../../../core/database/database.dart';
import '../../../core/utils/result.dart';

/// Free-form Markdown notebooks per document/project
/// (docs/03_DATABASE.md §3.10).
class NotebookRepository {
  NotebookRepository({required AnnotationDao dao, required String projectId})
      : _dao = dao,
        _projectId = projectId;

  final AnnotationDao _dao;
  final String _projectId;
  static const _uuid = Uuid();

  /// Returns the document notebook, creating it if missing.
  Future<Result<NotebookRow, Failure>> getOrCreateForDocument(
    String documentId,
    String title,
  ) async {
    try {
      final existing = await _dao.getNotebookForDocument(documentId);
      if (existing != null) return Result.ok(existing);
      final id = _uuid.v4();
      final now = DateTime.now().millisecondsSinceEpoch;
      await _dao.insertNotebook(NotebooksCompanion(
        id: Value(id),
        projectId: Value(_projectId),
        documentId: Value(documentId),
        title: Value(title),
        createdAt: Value(now),
        updatedAt: Value(now),
      ));
      final created = await _dao.getNotebookForDocument(documentId);
      return Result.ok(created!);
    } catch (e) {
      return Result.error(DatabaseFailure('Falha ao abrir caderno: $e'));
    }
  }

  Future<Result<void, Failure>> saveContent(String id, String content) async {
    try {
      await _dao.updateNotebook(
        id,
        NotebooksCompanion(
          content: Value(content),
          updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
        ),
      );
      return const Result.ok(null);
    } catch (e) {
      return Result.error(DatabaseFailure('Falha ao salvar caderno: $e'));
    }
  }
}
