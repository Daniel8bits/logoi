// dart format width=80
// ignore_for_file: type=lint
part of 'project_dao.dart';

mixin _$ProjectDaoMixin on DatabaseAccessor<LogoiDatabase> {
  $ProjectsTable get projects => attachedDatabase.projects;
  ProjectDaoManager get managers => ProjectDaoManager(this);
}

class ProjectDaoManager {
  final _$ProjectDaoMixin _db;
  ProjectDaoManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db.attachedDatabase, _db.projects);
}
