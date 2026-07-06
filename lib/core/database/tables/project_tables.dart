import 'package:drift/drift.dart';

/// See docs/03_DATABASE.md §3.1
@DataClassName('ProjectRow')
class Projects extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get area => text().nullable()();
  TextColumn get language => text().withDefault(const Constant('pt-BR'))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  /// JSON: ProjectSettings serialized.
  TextColumn get settings => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
