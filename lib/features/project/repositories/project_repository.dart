import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/database.dart';
import '../../../core/services/file_service.dart';
import '../../../core/utils/result.dart';
import '../models/project_settings.dart';
import '../models/project_summary.dart';

/// Manages the one-db-per-project storage model (docs/03_DATABASE.md §1):
/// creates, lists, opens and deletes project databases.
class ProjectRepository {
  ProjectRepository({required FileService fileService})
      : _fileService = fileService;

  final FileService _fileService;
  static const _uuid = Uuid();

  /// Scans the projects directory and builds card summaries.
  Future<Result<List<ProjectSummary>, Failure>> listProjects() async {
    try {
      final files = await _fileService.listProjectDbFiles();
      final summaries = <ProjectSummary>[];
      for (final file in files) {
        final summary = await _readSummary(file);
        if (summary != null) summaries.add(summary);
      }
      summaries.sort((a, b) =>
          (b.lastReadAt ?? 0).compareTo(a.lastReadAt ?? 0));
      return Result.ok(summaries);
    } catch (e) {
      return Result.error(DatabaseFailure('Falha ao listar projetos: $e'));
    }
  }

  Future<ProjectSummary?> _readSummary(File file) async {
    final db = LogoiDatabase.atPath(file.path);
    try {
      final projects = await db.projectDao.getAll();
      if (projects.isEmpty) return null;
      final project = projects.first;

      final documents = await db.documentDao.getByProject(project.id);
      var annotationCount = 0;
      var pagesRead = 0;
      var pagesTotal = 0;
      int? lastReadAt;
      for (final doc in documents) {
        annotationCount += (await db.annotationDao.getByDocument(doc.id)).length;
        pagesRead += doc.lastReadPage;
        pagesTotal += doc.totalPages ?? 0;
        final sessions = await db.documentDao.getReadingSessions(doc.id);
        if (sessions.isNotEmpty) {
          final latest = sessions.first.startedAt;
          if (lastReadAt == null || latest > lastReadAt) lastReadAt = latest;
        }
      }

      return ProjectSummary(
        id: project.id,
        name: project.name,
        description: project.description,
        area: project.area,
        documentCount: documents.length,
        annotationCount: annotationCount,
        readProgress: pagesTotal > 0 ? pagesRead / pagesTotal : 0,
        lastReadAt: lastReadAt,
      );
    } finally {
      await db.close();
    }
  }

  Future<Result<String, Failure>> createProject({
    required String name,
    String? description,
    String? area,
    String language = 'pt-BR',
    ProjectSettings settings = const ProjectSettings(),
  }) async {
    try {
      final id = _uuid.v4();
      final dbPath = await _fileService.projectDbPath(id);
      final db = LogoiDatabase.atPath(dbPath);
      final now = DateTime.now().millisecondsSinceEpoch;
      await db.projectDao.insertProject(ProjectsCompanion(
        id: Value(id),
        name: Value(name),
        description: Value(description),
        area: Value(area),
        language: Value(language),
        createdAt: Value(now),
        updatedAt: Value(now),
        settings: Value(jsonEncode(settings.toJson())),
      ));
      await db.close();
      return Result.ok(id);
    } catch (e) {
      return Result.error(DatabaseFailure('Falha ao criar projeto: $e'));
    }
  }

  /// Opens a project database. Caller owns the returned instance.
  Future<Result<LogoiDatabase, Failure>> openProject(String projectId) async {
    try {
      final dbPath = await _fileService.projectDbPath(projectId);
      if (!File(dbPath).existsSync()) {
        return Result.error(DatabaseFailure('Projeto não encontrado'));
      }
      final db = LogoiDatabase.atPath(dbPath);
      // Orphan reading-session cleanup on open (docs/03_DATABASE.md §3.19).
      await db.documentDao.cleanupOrphanSessions();
      return Result.ok(db);
    } catch (e) {
      return Result.error(DatabaseFailure('Falha ao abrir projeto: $e'));
    }
  }

  Future<Result<void, Failure>> renameProject(
    String projectId,
    String newName,
  ) async {
    try {
      final dbPath = await _fileService.projectDbPath(projectId);
      final db = LogoiDatabase.atPath(dbPath);
      await db.projectDao.updateProject(
        projectId,
        ProjectsCompanion(
          name: Value(newName),
          updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
        ),
      );
      await db.close();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(DatabaseFailure('Falha ao renomear projeto: $e'));
    }
  }

  Future<Result<void, Failure>> deleteProject(String projectId) async {
    try {
      await _fileService.deleteProjectDb(projectId);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(FileFailure('Falha ao excluir projeto: $e'));
    }
  }
}
