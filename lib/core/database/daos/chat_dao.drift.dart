// dart format width=80
// ignore_for_file: type=lint
part of 'chat_dao.dart';

mixin _$ChatDaoMixin on DatabaseAccessor<LogoiDatabase> {
  $ProjectsTable get projects => attachedDatabase.projects;
  $DocumentsTable get documents => attachedDatabase.documents;
  $ChatSessionsTable get chatSessions => attachedDatabase.chatSessions;
  $ChatMessagesTable get chatMessages => attachedDatabase.chatMessages;
  ChatDaoManager get managers => ChatDaoManager(this);
}

class ChatDaoManager {
  final _$ChatDaoMixin _db;
  ChatDaoManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db.attachedDatabase, _db.projects);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db.attachedDatabase, _db.documents);
  $$ChatSessionsTableTableManager get chatSessions =>
      $$ChatSessionsTableTableManager(_db.attachedDatabase, _db.chatSessions);
  $$ChatMessagesTableTableManager get chatMessages =>
      $$ChatMessagesTableTableManager(_db.attachedDatabase, _db.chatMessages);
}
