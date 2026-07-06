import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../project/providers/project_providers.dart';
import '../repositories/notebook_repository.dart';

part 'notebook_providers.g.dart';

@riverpod
NotebookRepository notebookRepository(Ref ref) {
  final context = ref.watch(currentProjectProvider);
  if (context == null) {
    throw StateError('No project open');
  }
  return NotebookRepository(
    dao: context.db.annotationDao,
    projectId: context.project.id,
  );
}
