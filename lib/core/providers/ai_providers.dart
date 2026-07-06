import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/project/providers/project_providers.dart';
import '../../features/settings/repositories/ai_settings_repository.dart';
import '../ai/guard_limits.dart';
import '../ai/request_throttler.dart';
import '../ai/usage_guard.dart';
import '../ai/errors.dart';
import '../ai/provider.dart';
import '../ai/providers/direct_anthropic_provider.dart';
import '../ai/providers/direct_openai_provider.dart';
import '../ai/providers/ollama_provider.dart';
import '../ai/providers/openrouter_provider.dart';
import '../ai/router.dart';
import '../cache/ai_cache.dart';
import '../database/database.dart';
import 'core_providers.dart';

part 'ai_providers.g.dart';

/// Global database — holds only app-level AI provider configuration
/// (docs/03_DATABASE.md §4: ai_providers is global, not per project).
@Riverpod(keepAlive: true)
Future<LogoiDatabase> globalDatabase(Ref ref) async {
  final path = await ref.watch(fileServiceProvider).globalDbPath();
  final db = LogoiDatabase.atPath(path);
  ref.onDispose(db.close);
  return db;
}

@Riverpod(keepAlive: true)
Future<AiSettingsRepository> aiSettingsRepository(Ref ref) async {
  final globalDb = await ref.watch(globalDatabaseProvider.future);
  return AiSettingsRepository(
    globalAiDao: globalDb.aiDao,
    secureStorage: ref.watch(secureStorageProvider),
  );
}

/// Creates a ready provider instance for a route, pulling the API key from
/// secure storage and the base URL from the global configuration.
Future<AIProvider> _createProvider(
  AITaskRoute route,
  AiSettingsRepository settings,
) async {
  final config = await settings.getProvider(route.providerId);
  switch (route.providerId) {
    case KnownProviders.openrouter:
      final key = await settings.getApiKey(route.providerId);
      if (key == null || key.isEmpty) {
        throw InvalidAPIKeyError('OpenRouter não configurado',
            providerName: 'OpenRouter');
      }
      return OpenRouterProvider(apiKey: key, model: route.model);
    case KnownProviders.openai:
      final key = await settings.getApiKey(route.providerId);
      if (key == null || key.isEmpty) {
        throw InvalidAPIKeyError('OpenAI não configurado',
            providerName: 'OpenAI');
      }
      return DirectOpenAIProvider(apiKey: key, model: route.model);
    case KnownProviders.anthropic:
      final key = await settings.getApiKey(route.providerId);
      if (key == null || key.isEmpty) {
        throw InvalidAPIKeyError('Anthropic não configurado',
            providerName: 'Anthropic');
      }
      return DirectAnthropicProvider(apiKey: key, model: route.model);
    case KnownProviders.ollama:
      return OllamaProvider(
        model: route.model,
        baseUrl: config?.baseUrl ?? 'http://localhost:11434',
      );
    default:
      throw ModelUnavailableError(
        'Provider ${route.providerId} não suportado',
        model: route.model,
        provider: route.providerId,
      );
  }
}

/// Per-project throttler (in-memory, reset when project closes).
@Riverpod(keepAlive: true)
class ProjectThrottler extends _$ProjectThrottler {
  @override
  AIRequestThrottler? build() {
    final context = ref.watch(currentProjectProvider);
    if (context == null) return null;
    return AIRequestThrottler(
      limits: AIGuardLimits.fromProjectSettings(
        maxApiRequestsPerHour: context.settings.maxApiRequestsPerHour,
        maxTokensPerDay: context.settings.maxTokensPerDay,
        maxCostUsdPerMonth: context.settings.maxCostUsdPerMonth,
        minSecondsBetweenCalls: context.settings.minSecondsBetweenCalls,
        maxCallsPerMinute: context.settings.maxCallsPerMinute,
        circuitBreakerEnabled: context.settings.circuitBreakerEnabled,
      ),
    );
  }

  void reset() {
    state?.reset();
    ref.invalidateSelf();
  }
}

/// Usage quota snapshot for the open project dashboard.
@riverpod
Future<AIUsageSnapshot?> aiUsageSnapshot(Ref ref) async {
  final context = ref.watch(currentProjectProvider);
  if (context == null) return null;
  final guard = AIUsageGuard(
    aiDao: context.db.aiDao,
    projectId: context.project.id,
    limits: AIGuardLimits.fromProjectSettings(
      maxApiRequestsPerHour: context.settings.maxApiRequestsPerHour,
      maxTokensPerDay: context.settings.maxTokensPerDay,
      maxCostUsdPerMonth: context.settings.maxCostUsdPerMonth,
      minSecondsBetweenCalls: context.settings.minSecondsBetweenCalls,
      maxCallsPerMinute: context.settings.maxCallsPerMinute,
      circuitBreakerEnabled: context.settings.circuitBreakerEnabled,
    ),
  );
  return guard.snapshot();
}

/// AIRouter for the currently open project. Null when no project is open.
@riverpod
Future<AIRouter?> aiRouter(Ref ref) async {
  final context = ref.watch(currentProjectProvider);
  if (context == null) return null;
  final settings = await ref.watch(aiSettingsRepositoryProvider.future);
  final throttler = ref.watch(projectThrottlerProvider);
  if (throttler == null) return null;

  final projectSettings = context.settings;
  final limits = AIGuardLimits.fromProjectSettings(
    maxApiRequestsPerHour: projectSettings.maxApiRequestsPerHour,
    maxTokensPerDay: projectSettings.maxTokensPerDay,
    maxCostUsdPerMonth: projectSettings.maxCostUsdPerMonth,
    minSecondsBetweenCalls: projectSettings.minSecondsBetweenCalls,
    maxCallsPerMinute: projectSettings.maxCallsPerMinute,
    circuitBreakerEnabled: projectSettings.circuitBreakerEnabled,
  );
  throttler.updateLimits(limits);

  return AIRouter(
    config: AIRouterConfig(
      defaultRoute: AITaskRoute(
        providerId: projectSettings.defaultProvider,
        model: projectSettings.defaultModel,
      ),
      summaryRoute: AITaskRoute(
        providerId: projectSettings.summaryProvider,
        model: projectSettings.summaryModel,
      ),
    ),
    providerFactory: (route) => _createProvider(route, settings),
    cache: AICacheStrategy(context.db.aiDao),
    aiDao: context.db.aiDao,
    throttler: throttler,
    usageGuard: AIUsageGuard(
      aiDao: context.db.aiDao,
      projectId: context.project.id,
      limits: limits,
    ),
    projectId: context.project.id,
  );
}
