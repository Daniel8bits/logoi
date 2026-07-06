import 'dart:async';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../cache/ai_cache.dart';
import '../database/daos/ai_dao.dart';
import '../database/database.dart';
import '../utils/result.dart';
import 'errors.dart';
import 'models.dart';
import 'prompts/prompts.dart';
import 'provider.dart';

/// Routing target: which provider/model handles a task.
class AITaskRoute {
  const AITaskRoute({required this.providerId, required this.model});

  final String providerId;
  final String model;
}

/// Router configuration resolved from user/project settings.
class AIRouterConfig {
  const AIRouterConfig({
    required this.defaultRoute,
    this.summaryRoute,
    this.taskOverrides = const {},
  });

  /// Global/project default.
  final AITaskRoute defaultRoute;

  /// Cheap model for batch summaries (docs/01_OVERVIEW.md §4.4).
  final AITaskRoute? summaryRoute;

  /// Explicit per-task overrides configured by the user.
  final Map<AITask, AITaskRoute> taskOverrides;
}

/// Creates a ready-to-use provider for a route (injected so the router
/// stays testable and free of secure-storage concerns).
typedef ProviderFactory = Future<AIProvider> Function(AITaskRoute route);

/// Single entry point for every AI call in the app
/// (docs/02_ARCHITECTURE.md §4.1, docs/04_AI_LAYER.md §1.2).
class AIRouter {
  AIRouter({
    required AIRouterConfig config,
    required ProviderFactory providerFactory,
    required AICacheStrategy cache,
    required AiDao aiDao,
    this.projectId,
  })  : _config = config,
        _providerFactory = providerFactory,
        _cache = cache,
        _aiDao = aiDao;

  final AIRouterConfig _config;
  final ProviderFactory _providerFactory;
  final AICacheStrategy _cache;
  final AiDao _aiDao;
  final String? projectId;

  static const _uuid = Uuid();

  /// Tasks whose responses are conversational and therefore never cached.
  static const _uncachedTasks = {AITask.chat, AITask.socratic};

  static const _summaryTasks = {
    AITask.sectionSummary,
    AITask.chapterSummary,
    AITask.documentSummary,
    AITask.historyCompression,
  };

  /// Resolution order: per-task override → summary route (batch tasks) →
  /// default route.
  AITaskRoute resolveRoute(AITask task) {
    final override = _config.taskOverrides[task];
    if (override != null) return override;
    if (_summaryTasks.contains(task) && _config.summaryRoute != null) {
      return _config.summaryRoute!;
    }
    return _config.defaultRoute;
  }

  Future<AIProvider> resolveProvider(AITask task) =>
      _providerFactory(resolveRoute(task));

  /// Streaming responses (chat, explain). Not cached.
  Stream<String> stream({
    required AITask task,
    required List<AIChatMessage> messages,
    double temperature = 0.7,
    int maxTokens = 2048,
    String? documentId,
  }) async* {
    final provider = await resolveProvider(task);
    final buffer = StringBuffer();
    await for (final chunk in provider.streamCompletion(
      messages: messages,
      temperature: temperature,
      maxTokens: maxTokens,
    )) {
      buffer.write(chunk);
      yield chunk;
    }
    await _logUsage(
      task: task,
      provider: provider,
      input: messages.map((m) => m.content).join('\n'),
      output: buffer.toString(),
      cacheHit: false,
      documentId: documentId,
    );
  }

  /// Complete responses (batch summaries, flashcards). Cached when the
  /// task allows it (docs/05_PROCESSING.md §8).
  Future<Result<String, AIFailure>> complete({
    required AITask task,
    required List<AIChatMessage> messages,
    double temperature = 0.3,
    int maxTokens = 4096,
    Map<String, dynamic>? responseFormat,
    String? documentId,
    bool forceRegenerate = false,
  }) async {
    final route = resolveRoute(task);
    final input = messages.map((m) => m.content).join('\n');
    final promptVersion = Prompts.forTask(task).version;
    final cacheable = !_uncachedTasks.contains(task);

    if (cacheable && !forceRegenerate) {
      final cached = await _cache.lookup(
        mode: task.name,
        promptVersion: promptVersion,
        input: input,
        model: route.model,
      );
      if (cached != null) {
        await _logUsage(
          task: task,
          providerId: route.providerId,
          model: route.model,
          input: '',
          output: '',
          cacheHit: true,
          documentId: documentId,
        );
        return Result.ok(cached);
      }
    }

    final provider = await _providerFactory(route);
    try {
      final response = await _completeWithRetry(
        provider,
        messages: messages,
        temperature: temperature,
        maxTokens: maxTokens,
        responseFormat: responseFormat,
      );
      if (cacheable) {
        await _cache.store(
          mode: task.name,
          promptVersion: promptVersion,
          input: input,
          provider: provider.id,
          model: provider.model,
          response: response,
          inputTokens: estimateTokens(input),
          outputTokens: estimateTokens(response),
        );
      }
      await _logUsage(
        task: task,
        provider: provider,
        input: input,
        output: response,
        cacheHit: false,
        documentId: documentId,
      );
      return Result.ok(response);
    } on AIError catch (e) {
      return Result.error(AIFailure(e.message));
    }
  }

  /// Automatic retry for rate limits (docs/04_AI_LAYER.md §10).
  Future<String> _completeWithRetry(
    AIProvider provider, {
    required List<AIChatMessage> messages,
    required double temperature,
    required int maxTokens,
    Map<String, dynamic>? responseFormat,
    int retriesLeft = 2,
  }) async {
    try {
      return await provider.complete(
        messages: messages,
        temperature: temperature,
        maxTokens: maxTokens,
        responseFormat: responseFormat,
      );
    } on RateLimitError catch (e) {
      if (retriesLeft <= 0) rethrow;
      await Future<void>.delayed(e.retryAfter);
      return _completeWithRetry(
        provider,
        messages: messages,
        temperature: temperature,
        maxTokens: maxTokens,
        responseFormat: responseFormat,
        retriesLeft: retriesLeft - 1,
      );
    }
  }

  Future<void> _logUsage({
    required AITask task,
    AIProvider? provider,
    String? providerId,
    String? model,
    required String input,
    required String output,
    required bool cacheHit,
    String? documentId,
  }) =>
      _aiDao.logUsage(ApiUsageLogCompanion(
        id: Value(_uuid.v4()),
        projectId: Value(projectId),
        documentId: Value(documentId),
        provider: Value(provider?.id ?? providerId ?? 'unknown'),
        model: Value(provider?.model ?? model ?? 'unknown'),
        feature: Value(task.name),
        inputTokens: Value(estimateTokens(input)),
        outputTokens: Value(estimateTokens(output)),
        cacheHit: Value(cacheHit),
        calledAt: Value(DateTime.now().millisecondsSinceEpoch),
      ));

  /// Rough token estimate (~4 chars/token) used for the cost dashboard.
  static int estimateTokens(String text) => (text.length / 4).ceil();
}
