import 'package:drift/drift.dart';

import 'document_tables.dart';
import 'project_tables.dart';

/// See docs/03_DATABASE.md §3.11
@DataClassName('ConceptRow')
class Concepts extends Table {
  TextColumn get id => text()();
  TextColumn get projectId =>
      text().references(Projects, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get definition => text().nullable()();

  /// 'theoretical' | 'methodological' | 'empirical' | 'person' | 'event' | 'place'
  TextColumn get type => text().nullable()();

  /// 'user' | 'ai'
  TextColumn get source => text()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// See docs/03_DATABASE.md §3.12
@DataClassName('ConceptRelationRow')
class ConceptRelations extends Table {
  TextColumn get id => text()();
  TextColumn get projectId =>
      text().references(Projects, #id, onDelete: KeyAction.cascade)();
  TextColumn get sourceId =>
      text().references(Concepts, #id, onDelete: KeyAction.cascade)();
  TextColumn get targetId =>
      text().references(Concepts, #id, onDelete: KeyAction.cascade)();

  /// 'defines' | 'contradicts' | 'supports' | 'exemplifies' | 'precedes'
  TextColumn get relation => text()();
  TextColumn get description => text().nullable()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {sourceId, targetId, relation},
      ];
}

/// See docs/03_DATABASE.md §3.13
@DataClassName('CrossReferenceRow')
class CrossReferences extends Table {
  TextColumn get id => text()();
  TextColumn get projectId =>
      text().references(Projects, #id, onDelete: KeyAction.cascade)();
  TextColumn get sourceDocId =>
      text().references(Documents, #id, onDelete: KeyAction.cascade)();
  IntColumn get sourcePage => integer()();
  TextColumn get sourceText => text()();
  TextColumn get targetDocId =>
      text().references(Documents, #id, onDelete: KeyAction.cascade)();
  IntColumn get targetPage => integer()();
  TextColumn get targetText => text()();

  /// 'corroborates' | 'contradicts' | 'extends' | 'cites' | 'exemplifies'
  TextColumn get relationType => text()();

  /// 0.0–1.0, null when created manually.
  RealColumn get confidence => real().nullable()();

  /// 'user' | 'ai'
  TextColumn get sourceOrigin => text().withDefault(const Constant('user'))();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
