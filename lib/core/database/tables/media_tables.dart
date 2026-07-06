import 'package:drift/drift.dart';

import 'project_tables.dart';

/// Cached visual reference lookups (selection hash + doc context).
@DataClassName('MediaReferenceCacheRow')
class MediaReferenceCache extends Table {
  TextColumn get id => text()();
  TextColumn get projectId =>
      text().references(Projects, #id, onDelete: KeyAction.cascade)();
  TextColumn get cacheKey => text().unique()();
  TextColumn get payload => text()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
