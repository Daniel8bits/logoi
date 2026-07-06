import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/file_service.dart';
import '../services/ollama_service.dart';
import '../services/secure_storage.dart';
import '../../features/project/repositories/project_repository.dart';
import '../../shared/theme/app_theme.dart';

part 'core_providers.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError('Overridden in main()');
}

@Riverpod(keepAlive: true)
FileService fileService(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return FileService(customProjectsDir: prefs.getString('projects_dir'));
}

@Riverpod(keepAlive: true)
SecureStorageService secureStorage(Ref ref) => SecureStorageService();

@Riverpod(keepAlive: true)
OllamaService ollamaService(Ref ref) => OllamaService();

@Riverpod(keepAlive: true)
ProjectRepository projectRepository(Ref ref) =>
    ProjectRepository(fileService: ref.watch(fileServiceProvider));

/// Global theme selection persisted in SharedPreferences.
@Riverpod(keepAlive: true)
class ThemeController extends _$ThemeController {
  static const _key = 'theme_mode';

  @override
  LogoiThemeMode build() {
    final saved = ref.watch(sharedPreferencesProvider).getString(_key);
    return LogoiThemeMode.values.firstWhere(
      (m) => m.name == saved,
      orElse: () => LogoiThemeMode.light,
    );
  }

  Future<void> setMode(LogoiThemeMode mode) async {
    state = mode;
    await ref.read(sharedPreferencesProvider).setString(_key, mode.name);
  }
}

/// Ollama availability, checked on startup and refreshable.
@Riverpod(keepAlive: true)
class OllamaStatus extends _$OllamaStatus {
  @override
  Future<bool> build() => ref.watch(ollamaServiceProvider).isAvailable();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await ref.read(ollamaServiceProvider).isAvailable());
  }
}
