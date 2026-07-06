import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

/// File-system concerns: projects directory, PDF picking
/// (docs/02_ARCHITECTURE.md — core/services).
class FileService {
  FileService({this.customProjectsDir});

  /// User-configurable projects directory (docs/06_UI_UX.md §5.2).
  final String? customProjectsDir;

  Future<Directory> projectsDirectory() async {
    final Directory base;
    if (customProjectsDir != null && customProjectsDir!.isNotEmpty) {
      base = Directory(customProjectsDir!);
    } else {
      final support = await getApplicationSupportDirectory();
      base = Directory('${support.path}${Platform.pathSeparator}projects');
    }
    if (!base.existsSync()) base.createSync(recursive: true);
    return base;
  }

  Future<String> projectDbPath(String projectId) async {
    final dir = await projectsDirectory();
    return '${dir.path}${Platform.pathSeparator}$projectId.db';
  }

  Future<String> globalDbPath() async {
    final support = await getApplicationSupportDirectory();
    return '${support.path}${Platform.pathSeparator}global.db';
  }

  /// Lists project database files in the projects directory.
  Future<List<File>> listProjectDbFiles() async {
    final dir = await projectsDirectory();
    return dir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.db'))
        .toList();
  }

  /// Opens the OS file picker restricted to PDFs.
  Future<String?> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    return result?.files.single.path;
  }

  Future<void> deleteProjectDb(String projectId) async {
    final path = await projectDbPath(projectId);
    final file = File(path);
    if (file.existsSync()) await file.delete();
  }
}
