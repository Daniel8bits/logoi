import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/daos/document_dao.dart';
import '../../../core/database/database.dart';
import '../../../core/processing/pipeline.dart';
import '../../../core/utils/result.dart';

/// Document import and reading-progress logic.
class DocumentRepository {
  DocumentRepository({required DocumentDao dao, required String projectId})
      : _dao = dao,
        _projectId = projectId,
        _pipeline = ImportPipeline(documentDao: dao);

  final DocumentDao _dao;
  final String _projectId;
  final ImportPipeline _pipeline;
  static const _uuid = Uuid();

  Stream<List<DocumentRow>> watchDocuments() => _dao.watchByProject(_projectId);

  Stream<DocumentRow?> watchDocument(String id) => _dao.watchById(id);

  /// Imports a PDF: inserts the document row and runs pipeline stages 1-2.
  Future<Result<String, Failure>> importPdf(
    String filePath, {
    void Function(String status)? onStatus,
  }) async {
    try {
      final id = _uuid.v4();
      final fileName = filePath.split(RegExp(r'[/\\]')).last;
      await _dao.insertDocument(DocumentsCompanion(
        id: Value(id),
        projectId: Value(_projectId),
        fileName: Value(fileName),
        filePath: Value(filePath),
        importedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ));
      await _pipeline.run(
        documentId: id,
        filePath: filePath,
        onStatus: onStatus,
      );
      return Result.ok(id);
    } catch (e) {
      return Result.error(FileFailure('Falha ao importar PDF: $e'));
    }
  }

  Future<Result<void, Failure>> deleteDocument(String id) async {
    try {
      await _dao.deleteDocument(id);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(DatabaseFailure('Falha ao excluir documento: $e'));
    }
  }

  Future<void> updateLastReadPage(String documentId, int page) =>
      _dao.setLastReadPage(documentId, page);

  Future<List<StructureRow>> getStructure(String documentId) =>
      _dao.getStructure(documentId);

  Future<String?> getPageText(String documentId, int pageNumber) async {
    final page = await _dao.getPage(documentId, pageNumber);
    return page?.content;
  }

  // ── Reading sessions (docs/08_ROADMAP.md §1.8) ──

  Future<String> startReadingSession(String documentId, int startPage) async {
    final id = _uuid.v4();
    await _dao.insertReadingSession(ReadingSessionsCompanion(
      id: Value(id),
      documentId: Value(documentId),
      startPage: Value(startPage),
      endPage: Value(startPage),
      startedAt: Value(DateTime.now().millisecondsSinceEpoch),
    ));
    return id;
  }

  Future<void> endReadingSession(
    String sessionId,
    int endPage,
    Duration duration,
  ) =>
      _dao.endReadingSession(sessionId, endPage, duration.inSeconds);
}
