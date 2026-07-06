import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/project_tables.dart';

part 'project_dao.drift.dart';

@DriftAccessor(tables: [Projects])
class ProjectDao extends DatabaseAccessor<LogoiDatabase> with _$ProjectDaoMixin {
  ProjectDao(super.db);

  Future<List<ProjectRow>> getAll() =>
      (select(projects)..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])).get();

  Future<ProjectRow?> getById(String id) =>
      (select(projects)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> insertProject(ProjectsCompanion entry) =>
      into(projects).insert(entry);

  Future<void> updateProject(String id, ProjectsCompanion entry) =>
      (update(projects)..where((t) => t.id.equals(id))).write(entry);

  Future<void> deleteProject(String id) =>
      (delete(projects)..where((t) => t.id.equals(id))).go();
}
