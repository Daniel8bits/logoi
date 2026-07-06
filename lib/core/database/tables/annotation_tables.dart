import 'package:drift/drift.dart';

import 'document_tables.dart';
import 'project_tables.dart';

/// See docs/03_DATABASE.md §3.8
@DataClassName('AnnotationRow')
class Annotations extends Table {
  TextColumn get id => text()();
  TextColumn get documentId =>
      text().references(Documents, #id, onDelete: KeyAction.cascade)();
  IntColumn get pageNumber => integer()();

  /// 'highlight' | 'note' | 'bookmark' | 'question'
  TextColumn get type => text()();

  /// Hex color: '#FFEB3B'
  TextColumn get color => text().nullable()();
  TextColumn get selectedText => text().nullable()();

  /// Markdown content.
  TextColumn get content => text().nullable()();

  /// JSON: SelectionPosition { startOffset, endOffset, rects }
  TextColumn get position => text()();

  /// JSON array: ["tag1", "tag2"]
  TextColumn get tags => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// See docs/03_DATABASE.md §3.9
@DataClassName('AnnotationVersionRow')
class AnnotationVersions extends Table {
  TextColumn get id => text()();
  TextColumn get annotationId =>
      text().references(Annotations, #id, onDelete: KeyAction.cascade)();
  TextColumn get content => text()();
  IntColumn get changedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// See docs/03_DATABASE.md §3.10
@DataClassName('NotebookRow')
class Notebooks extends Table {
  TextColumn get id => text()();
  TextColumn get projectId =>
      text().references(Projects, #id, onDelete: KeyAction.cascade)();

  /// Null = project-level notebook.
  TextColumn get documentId =>
      text().nullable().references(Documents, #id, onDelete: KeyAction.setNull)();
  TextColumn get title => text()();
  TextColumn get content => text().withDefault(const Constant(''))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
