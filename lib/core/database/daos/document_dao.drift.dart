// dart format width=80
// ignore_for_file: type=lint
part of 'document_dao.dart';

mixin _$DocumentDaoMixin on DatabaseAccessor<LogoiDatabase> {
  $ProjectsTable get projects => attachedDatabase.projects;
  $DocumentsTable get documents => attachedDatabase.documents;
  $PageContentsTable get pageContents => attachedDatabase.pageContents;
  $ParagraphsTable get paragraphs => attachedDatabase.paragraphs;
  $ParagraphEmbeddingsTable get paragraphEmbeddings =>
      attachedDatabase.paragraphEmbeddings;
  $DocumentStructureTable get documentStructure =>
      attachedDatabase.documentStructure;
  $SectionSummariesTable get sectionSummaries =>
      attachedDatabase.sectionSummaries;
  $ReadingSessionsTable get readingSessions => attachedDatabase.readingSessions;
  DocumentDaoManager get managers => DocumentDaoManager(this);
}

class DocumentDaoManager {
  final _$DocumentDaoMixin _db;
  DocumentDaoManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db.attachedDatabase, _db.projects);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db.attachedDatabase, _db.documents);
  $$PageContentsTableTableManager get pageContents =>
      $$PageContentsTableTableManager(_db.attachedDatabase, _db.pageContents);
  $$ParagraphsTableTableManager get paragraphs =>
      $$ParagraphsTableTableManager(_db.attachedDatabase, _db.paragraphs);
  $$ParagraphEmbeddingsTableTableManager get paragraphEmbeddings =>
      $$ParagraphEmbeddingsTableTableManager(
        _db.attachedDatabase,
        _db.paragraphEmbeddings,
      );
  $$DocumentStructureTableTableManager get documentStructure =>
      $$DocumentStructureTableTableManager(
        _db.attachedDatabase,
        _db.documentStructure,
      );
  $$SectionSummariesTableTableManager get sectionSummaries =>
      $$SectionSummariesTableTableManager(
        _db.attachedDatabase,
        _db.sectionSummaries,
      );
  $$ReadingSessionsTableTableManager get readingSessions =>
      $$ReadingSessionsTableTableManager(
        _db.attachedDatabase,
        _db.readingSessions,
      );
}
