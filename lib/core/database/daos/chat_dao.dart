import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/chat_tables.dart';

part 'chat_dao.drift.dart';

@DriftAccessor(tables: [ChatSessions, ChatMessages])
class ChatDao extends DatabaseAccessor<LogoiDatabase> with _$ChatDaoMixin {
  ChatDao(super.db);

  // ── Sessions ──

  Stream<List<ChatSessionRow>> watchByProject(String projectId) =>
      (select(chatSessions)
            ..where((t) => t.projectId.equals(projectId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch();

  Future<List<ChatSessionRow>> getByDocument(String documentId) =>
      (select(chatSessions)
            ..where((t) => t.documentId.equals(documentId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .get();

  Future<void> insertSession(ChatSessionsCompanion entry) =>
      into(chatSessions).insert(entry);

  Future<void> updateSession(String id, ChatSessionsCompanion entry) =>
      (update(chatSessions)..where((t) => t.id.equals(id))).write(entry);

  Future<void> deleteSession(String id) =>
      (delete(chatSessions)..where((t) => t.id.equals(id))).go();

  // ── Messages ──

  Stream<List<ChatMessageRow>> watchMessages(String sessionId) =>
      (select(chatMessages)
            ..where((t) => t.sessionId.equals(sessionId))
            ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
          .watch();

  Future<List<ChatMessageRow>> getMessages(String sessionId) =>
      (select(chatMessages)
            ..where((t) => t.sessionId.equals(sessionId))
            ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
          .get();

  Future<void> insertMessage(ChatMessagesCompanion entry) =>
      into(chatMessages).insert(entry);

  Future<void> updateMessage(String id, ChatMessagesCompanion entry) =>
      (update(chatMessages)..where((t) => t.id.equals(id))).write(entry);

  Future<void> deleteMessages(List<String> ids) =>
      (delete(chatMessages)..where((t) => t.id.isIn(ids))).go();
}
