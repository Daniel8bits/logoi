import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/daos/annotation_dao.dart';
import '../../../core/database/database.dart';
import '../../../core/utils/result.dart';
import '../../reader/models/selection.dart';
import '../models/annotation_type.dart';

/// Annotation CRUD with automatic versioning
/// (docs/06_UI_UX.md §3.3: snapshot on save, min 30s interval).
class AnnotationRepository {
  AnnotationRepository({required AnnotationDao dao}) : _dao = dao;

  final AnnotationDao _dao;
  static const _uuid = Uuid();
  static const versionMinInterval = Duration(seconds: 30);

  Stream<List<AnnotationRow>> watchByDocument(String documentId) =>
      _dao.watchByDocument(documentId);

  Future<Result<String, Failure>> create({
    required String documentId,
    required int pageNumber,
    required AnnotationType type,
    required SelectionPosition position,
    String? color,
    String? selectedText,
    String? content,
    List<String> tags = const [],
  }) async {
    try {
      final id = _uuid.v4();
      final now = DateTime.now().millisecondsSinceEpoch;
      await _dao.insertAnnotation(AnnotationsCompanion(
        id: Value(id),
        documentId: Value(documentId),
        pageNumber: Value(pageNumber),
        type: Value(type.name),
        color: Value(color),
        selectedText: Value(selectedText),
        content: Value(content),
        position: Value(jsonEncode(position.toJson())),
        tags: Value(jsonEncode(tags)),
        createdAt: Value(now),
        updatedAt: Value(now),
      ));
      if (content != null && content.isNotEmpty) {
        await _snapshotVersion(id, content, force: true);
      }
      return Result.ok(id);
    } catch (e) {
      return Result.error(DatabaseFailure('Falha ao criar anotação: $e'));
    }
  }

  Future<Result<void, Failure>> updateContent(
    String id, {
    required String content,
    List<String>? tags,
    String? color,
  }) async {
    try {
      await _dao.updateAnnotation(
        id,
        AnnotationsCompanion(
          content: Value(content),
          tags: tags != null ? Value(jsonEncode(tags)) : const Value.absent(),
          color: color != null ? Value(color) : const Value.absent(),
          updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
        ),
      );
      await _snapshotVersion(id, content);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(DatabaseFailure('Falha ao atualizar anotação: $e'));
    }
  }

  Future<Result<void, Failure>> delete(String id) async {
    try {
      await _dao.deleteAnnotation(id);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(DatabaseFailure('Falha ao excluir anotação: $e'));
    }
  }

  Future<List<AnnotationVersionRow>> getVersions(String annotationId) =>
      _dao.getVersions(annotationId);

  /// Saves a version snapshot, respecting the 30s minimum interval.
  Future<void> _snapshotVersion(
    String annotationId,
    String content, {
    bool force = false,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (!force) {
      final latest = await _dao.getLatestVersion(annotationId);
      if (latest != null &&
          now - latest.changedAt < versionMinInterval.inMilliseconds) {
        return;
      }
    }
    await _dao.insertVersion(AnnotationVersionsCompanion(
      id: Value(_uuid.v4()),
      annotationId: Value(annotationId),
      content: Value(content),
      changedAt: Value(now),
    ));
  }

  static List<String> parseTags(String? tagsJson) {
    if (tagsJson == null || tagsJson.isEmpty) return const [];
    return (jsonDecode(tagsJson) as List<dynamic>).cast<String>();
  }

  static SelectionPosition parsePosition(String positionJson) =>
      SelectionPosition.fromJson(
          jsonDecode(positionJson) as Map<String, dynamic>);
}
