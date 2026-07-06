// dart format width=80
// ignore_for_file: type=lint
part of 'annotation_dao.dart';

mixin _$AnnotationDaoMixin on DatabaseAccessor<LogoiDatabase> {
  $ProjectsTable get projects => attachedDatabase.projects;
  $DocumentsTable get documents => attachedDatabase.documents;
  $AnnotationsTable get annotations => attachedDatabase.annotations;
  $AnnotationVersionsTable get annotationVersions =>
      attachedDatabase.annotationVersions;
  $NotebooksTable get notebooks => attachedDatabase.notebooks;
  AnnotationDaoManager get managers => AnnotationDaoManager(this);
}

class AnnotationDaoManager {
  final _$AnnotationDaoMixin _db;
  AnnotationDaoManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db.attachedDatabase, _db.projects);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db.attachedDatabase, _db.documents);
  $$AnnotationsTableTableManager get annotations =>
      $$AnnotationsTableTableManager(_db.attachedDatabase, _db.annotations);
  $$AnnotationVersionsTableTableManager get annotationVersions =>
      $$AnnotationVersionsTableTableManager(
        _db.attachedDatabase,
        _db.annotationVersions,
      );
  $$NotebooksTableTableManager get notebooks =>
      $$NotebooksTableTableManager(_db.attachedDatabase, _db.notebooks);
}
