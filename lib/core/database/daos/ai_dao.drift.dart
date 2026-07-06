// dart format width=80
// ignore_for_file: type=lint
part of 'ai_dao.dart';

mixin _$AiDaoMixin on DatabaseAccessor<LogoiDatabase> {
  $AiProvidersTable get aiProviders => attachedDatabase.aiProviders;
  $AiResponseCacheTable get aiResponseCache => attachedDatabase.aiResponseCache;
  $ProjectsTable get projects => attachedDatabase.projects;
  $DocumentsTable get documents => attachedDatabase.documents;
  $ApiUsageLogTable get apiUsageLog => attachedDatabase.apiUsageLog;
  AiDaoManager get managers => AiDaoManager(this);
}

class AiDaoManager {
  final _$AiDaoMixin _db;
  AiDaoManager(this._db);
  $$AiProvidersTableTableManager get aiProviders =>
      $$AiProvidersTableTableManager(_db.attachedDatabase, _db.aiProviders);
  $$AiResponseCacheTableTableManager get aiResponseCache =>
      $$AiResponseCacheTableTableManager(
        _db.attachedDatabase,
        _db.aiResponseCache,
      );
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db.attachedDatabase, _db.projects);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db.attachedDatabase, _db.documents);
  $$ApiUsageLogTableTableManager get apiUsageLog =>
      $$ApiUsageLogTableTableManager(_db.attachedDatabase, _db.apiUsageLog);
}
