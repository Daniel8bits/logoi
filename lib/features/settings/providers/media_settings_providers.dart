import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';
import '../repositories/media_settings_repository.dart';

part 'media_settings_providers.g.dart';

@Riverpod(keepAlive: true)
MediaSettingsRepository mediaSettingsRepository(Ref ref) =>
    MediaSettingsRepository(ref.watch(secureStorageProvider));

@riverpod
Future<bool> hasYoutubeApiKey(Ref ref) =>
    ref.watch(mediaSettingsRepositoryProvider).hasYoutubeKey();
