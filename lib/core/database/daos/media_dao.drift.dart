// dart format width=80
// ignore_for_file: type=lint
part of 'media_dao.dart';

mixin _$MediaDaoMixin on DatabaseAccessor<LogoiDatabase> {
  $ProjectsTable get projects => attachedDatabase.projects;
  $MediaReferenceCacheTable get mediaReferenceCache =>
      attachedDatabase.mediaReferenceCache;
  MediaDaoManager get managers => MediaDaoManager(this);
}

class MediaDaoManager {
  final _$MediaDaoMixin _db;
  MediaDaoManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db.attachedDatabase, _db.projects);
  $$MediaReferenceCacheTableTableManager get mediaReferenceCache =>
      $$MediaReferenceCacheTableTableManager(
        _db.attachedDatabase,
        _db.mediaReferenceCache,
      );
}
