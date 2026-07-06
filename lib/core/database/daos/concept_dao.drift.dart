// dart format width=80
// ignore_for_file: type=lint
part of 'concept_dao.dart';

mixin _$ConceptDaoMixin on DatabaseAccessor<LogoiDatabase> {
  $ProjectsTable get projects => attachedDatabase.projects;
  $ConceptsTable get concepts => attachedDatabase.concepts;
  $ConceptRelationsTable get conceptRelations =>
      attachedDatabase.conceptRelations;
  $DocumentsTable get documents => attachedDatabase.documents;
  $CrossReferencesTable get crossReferences => attachedDatabase.crossReferences;
  ConceptDaoManager get managers => ConceptDaoManager(this);
}

class ConceptDaoManager {
  final _$ConceptDaoMixin _db;
  ConceptDaoManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db.attachedDatabase, _db.projects);
  $$ConceptsTableTableManager get concepts =>
      $$ConceptsTableTableManager(_db.attachedDatabase, _db.concepts);
  $$ConceptRelationsTableTableManager get conceptRelations =>
      $$ConceptRelationsTableTableManager(
        _db.attachedDatabase,
        _db.conceptRelations,
      );
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db.attachedDatabase, _db.documents);
  $$CrossReferencesTableTableManager get crossReferences =>
      $$CrossReferencesTableTableManager(
        _db.attachedDatabase,
        _db.crossReferences,
      );
}
