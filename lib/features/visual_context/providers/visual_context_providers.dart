import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/ai_providers.dart';
import '../../project/providers/project_providers.dart';
import '../../settings/providers/media_settings_providers.dart';
import '../models/media_reference.dart';
import '../repositories/visual_context_repository.dart';
import '../services/image_search_service.dart';
import '../services/video_search_service.dart';

part 'visual_context_providers.g.dart';

@riverpod
Future<VisualContextRepository?> visualContextRepository(Ref ref) async {
  final context = ref.watch(currentProjectProvider);
  if (context == null) return null;
  final router = await ref.watch(aiRouterProvider.future);
  final mediaSettings = ref.watch(mediaSettingsRepositoryProvider);
  return VisualContextRepository(
    mediaDao: context.db.mediaDao,
    projectId: context.project.id,
    imageSearch: ImageSearchService(mediaSettings: mediaSettings),
    videoSearch: VideoSearchService(mediaSettings: mediaSettings),
    router: router,
  );
}

@riverpod
Future<MediaReferenceBundle?> mediaReferenceBundle(
  Ref ref, {
  required String selectionText,
  String? documentTitle,
  int? pageNumber,
  bool includeImages = true,
  bool includeVideos = true,
}) async {
  final repository = await ref.watch(visualContextRepositoryProvider.future);
  if (repository == null) return null;
  return repository.resolve(
    selectionText: selectionText,
    documentTitle: documentTitle,
    pageNumber: pageNumber,
    userLanguage: ref.watch(currentProjectProvider)?.project.language ?? 'pt-BR',
    includeImages: includeImages,
    includeVideos: includeVideos,
  );
}
