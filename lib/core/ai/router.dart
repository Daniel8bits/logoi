import 'dart:async';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../cache/ai_cache.dart';
import '../database/daos/ai_dao.dart';
import '../database/database.dart';
import '../utils/result.dart';
import 'errors.dart';
import 'guard_limits.dart';
import 'models.dart';
import 'pricing.dart';
import 'prompts/prompts.dart';
import 'provider.dart';
import 'request_throttler.dart';
import 'usage_guard.dart';

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

  final AITaskRoute defaultRoute;
  final AITaskRoute? summaryRoute;
  final Map<AITask, AITaskRoute> taskOverrides;
}

typedef ProviderFactory = Future<AIProvider> Function(AITaskRoute route);

/// Single entry point for every AI call in the app
/// (docs/02_ARCHITECTURE.md §4.1, docs/04_AI_LAYER.md §1.2).
class AIRouter {
  AIRouter({
    required AIRouterConfig config,
    required ProviderFactory providerFactory,
    required AICacheStrategy cache,
    required AiDao aiDao,
    required AIRequestThrottler throttler,
    required AIUsageGuard usageGuard,
    this.projectId,
  })  : _config = config,
        _providerFactory = providerFactory,
        _cache = cache,
        _aiDao = aiDao,
        _throttler = throttler,
        _usageGuard = usageGuard;

  final AIRouterConfig _config;
  final ProviderFactory _providerFactory;
  final AICacheStrategy _cache;
  final AiDao _aiDao;
  final AIRequestThrottler _throttler;
  final AIUsageGuard _usageGuard;
  final String? projectId;

  static const _uuid = Uuid();

  static const _uncachedTasks = {AITask.chat, AITask.socratic};

  static const _summaryTasks = {
    AITask.sectionSummary,
    AITask.chapterSummary,
    AITask.documentSummary,
    AITask.historyCompression,
  };

  final _inFlightComplete = <String, Future<Result<String, AIFailure>>>{};

  AIRequestThrottler get throttler => _throttler;
  AIUsageGuard get usageGuard => _usageGuard;

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
    final route = resolveRoute(task);
    final input = messages.map((m) => m.content).join('\n');
    final dedupKey = _dedupKey(task, route.model, input);

    await _guardRealCall();
    final handle = _throttler.acquire(dedupKey: dedupKey);
    await handle.waitIfDuplicate;

    try {
      final provider = await _providerFactory(route);
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
        input: input,
        output: buffer.toString(),
        cacheHit: false,
        documentId: documentId,
      );
      _throttler.recordSuccess();
    } on AIError {
      _throttler.recordError();
      rethrow;
    } finally {
      handle.release();
    }
  }

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
    final dedupKey = _dedupKey(task, route.model, input);

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

    final existing = _inFlightComplete[dedupKey];
    if (existing != null) return existing;

    final future = _completeInternal(
      task: task,
      route: route,
      messages: messages,
      input: input,
      promptVersion: promptVersion,
      cacheable: cacheable,
      temperature: temperature,
      maxTokens: maxTokens,
      responseFormat: responseFormat,
      documentId: documentId,
      dedupKey: dedupKey,
    );
    _inFlightComplete[dedupKey] = future;
    try {
      return await future;
    } finally {
      _inFlightComplete.remove(dedupKey);
    }
  }

  Future<Result<String, AIFailure>> _completeInternal({
    required AITask task,
    required AITaskRoute route,
    required List<AIChatMessage> messages,
    required String input,
    required String promptVersion,
    required bool cacheable,
    required double temperature,
    required int maxTokens,
    Map<String, dynamic>? responseFormat,
    String? documentId,
    required String dedupKey,
  }) async {
    await _guardRealCall();
    final handle = _throttler.acquire(dedupKey: dedupKey);
    await handle.waitIfDuplicate;

    try {
      final provider = await _providerFactory(route);
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
      _throttler.recordSuccess();
      return Result.ok(response);
    } on QuotaExceededError catch (e) {
      return Result.error(AIFailure(e.message));
    } on ThrottleExceededError catch (e) {
      return Result.error(AIFailure(e.message));
    } on InsufficientCreditsError catch (e) {
      return Result.error(AIFailure(e.message));
    } on AIError catch (e) {
      _throttler.recordError();
      return Result.error(AIFailure(e.message));
    } finally {
      handle.release();
    }
  }

  Future<void> _guardRealCall() async {
    _throttler.checkAllowed();
    await _usageGuard.checkAllowed();
  }

  String _dedupKey(AITask task, String model, String input) =>
      AICacheStrategy.cacheKey(
        mode: task.name,
        promptVersion: 'inflight',
        inputHash: AICacheStrategy.inputHash(input),
        model: model,
      );

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
    } on QuotaExceededError {
      rethrow;
    } on ThrottleExceededError {
      rethrow;
    } on InsufficientCreditsError {
      rethrow;
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
  }) {
    final resolvedModel = provider?.model ?? model ?? 'unknown';
    final inTok = estimateTokens(input);
    final outTok = estimateTokens(output);
    final cost = cacheHit
        ? 0.0
        : ModelPricing.estimateCostUsd(
            model: resolvedModel,
            inputTokens: inTok,
            outputTokens: outTok,
          );
    return _aiDao.logUsage(ApiUsageLogCompanion(
      id: Value(_uuid.v4()),
      projectId: Value(projectId),
      documentId: Value(documentId),
      provider: Value(provider?.id ?? providerId ?? 'unknown'),
      model: Value(resolvedModel),
      feature: Value(task.name),
      inputTokens: Value(inTok),
      outputTokens: Value(outTok),
      cacheHit: Value(cacheHit),
      costUsd: Value(cost),
      calledAt: Value(DateTime.now().millisecondsSinceEpoch),
    ));
  }

  static int estimateTokens(String text) => (text.length / 4).ceil();
}
