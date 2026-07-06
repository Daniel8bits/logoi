import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/ai_providers.dart';
import '../../project/providers/project_providers.dart';
import '../services/export_service.dart';

part 'export_providers.g.dart';

@riverpod
Future<ExportService?> exportService(Ref ref) async {
  final context = ref.watch(currentProjectProvider);
  if (context == null) return null;
  final router = await ref.watch(aiRouterProvider.future);
  return ExportService(
    annotationDao: context.db.annotationDao,
    conceptDao: context.db.conceptDao,
    projectId: context.project.id,
    projectName: context.project.name,
    userLanguage: context.project.language,
    router: router,
  );
}
