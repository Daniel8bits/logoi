import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database.dart';
import '../../../core/providers/ai_providers.dart';
import '../../../core/providers/core_providers.dart';
import '../models/project_settings.dart';
import '../models/project_summary.dart';

part 'project_providers.g.dart';

/// The currently open project: row, settings and its database handle.
class ProjectContext {
  const ProjectContext({
    required this.project,
    required this.settings,
    required this.db,
  });

  final ProjectRow project;
  final ProjectSettings settings;
  final LogoiDatabase db;
}

@riverpod
Future<List<ProjectSummary>> projectList(Ref ref) async {
  final result = await ref.watch(projectRepositoryProvider).listProjects();
  return result.when(
    ok: (projects) => projects,
    error: (failure) => throw Exception(failure.message),
  );
}

/// Holds the open project (docs/02_ARCHITECTURE.md — shared providers are
/// the only cross-feature communication channel).
@Riverpod(keepAlive: true)
class CurrentProject extends _$CurrentProject {
  @override
  ProjectContext? build() => null;

  Future<void> open(String projectId) async {
    await close();
    final repository = ref.read(projectRepositoryProvider);
    final result = await repository.openProject(projectId);
    final db = result.when(
      ok: (db) => db,
      error: (failure) => throw Exception(failure.message),
    );
    final project = await db.projectDao.getById(projectId);
    if (project == null) {
      await db.close();
      throw Exception('Projeto não encontrado');
    }
    final settings = project.settings != null
        ? ProjectSettings.fromJson(
            jsonDecode(project.settings!) as Map<String, dynamic>)
        : const ProjectSettings();
    state = ProjectContext(project: project, settings: settings, db: db);
  }

  Future<void> close() async {
    final current = state;
    state = null;
    ref.read(projectThrottlerProvider.notifier).reset();
    await current?.db.close();
  }

  Future<void> updateSettings(ProjectSettings settings) async {
    final current = state;
    if (current == null) return;
    await current.db.projectDao.updateProject(
      current.project.id,
      ProjectsCompanion(
        settings: Value(jsonEncode(settings.toJson())),
        updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
    state = ProjectContext(
      project: current.project,
      settings: settings,
      db: current.db,
    );
  }
}
