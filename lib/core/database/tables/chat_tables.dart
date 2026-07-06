import 'package:drift/drift.dart';

import 'document_tables.dart';
import 'project_tables.dart';

/// See docs/03_DATABASE.md §3.14
@DataClassName('ChatSessionRow')
class ChatSessions extends Table {
  TextColumn get id => text()();
  TextColumn get projectId =>
      text().references(Projects, #id, onDelete: KeyAction.cascade)();

  /// Null = project-level session.
  TextColumn get documentId =>
      text().nullable().references(Documents, #id, onDelete: KeyAction.setNull)();
  TextColumn get title => text().nullable()();
  TextColumn get provider => text()();
  TextColumn get model => text()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// See docs/03_DATABASE.md §3.15
@DataClassName('ChatMessageRow')
class ChatMessages extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId =>
      text().references(ChatSessions, #id, onDelete: KeyAction.cascade)();

  /// 'user' | 'assistant' | 'system'
  TextColumn get role => text()();
  TextColumn get content => text()();

  /// JSON: { selectedText, pageNumber, selectionLevel }
  TextColumn get context => text().nullable()();

  /// True when this row is a compressed summary of older turns.
  BoolColumn get isCompressed => boolean().withDefault(const Constant(false))();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
