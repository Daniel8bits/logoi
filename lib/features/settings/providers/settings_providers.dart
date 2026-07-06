import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database.dart';
import '../../../core/providers/ai_providers.dart';
import '../../../core/providers/core_providers.dart';

part 'settings_providers.g.dart';

@riverpod
Stream<List<AiProviderRow>> aiProviderConfigs(Ref ref) async* {
  final repository = await ref.watch(aiSettingsRepositoryProvider.future);
  yield* repository.watchProviders();
}

@riverpod
Future<bool> providerHasKey(Ref ref, String providerId) async {
  final repository = await ref.watch(aiSettingsRepositoryProvider.future);
  return repository.hasApiKey(providerId);
}

/// Aggregated usage stats for the cost dashboard (docs/06_UI_UX.md §5.1).
class UsageStats {
  const UsageStats({
    required this.inputTokens,
    required this.outputTokens,
    required this.estimatedCostUsd,
    required this.cacheHitRate,
  });

  final int inputTokens;
  final int outputTokens;
  final double estimatedCostUsd;
  final double cacheHitRate;
}

@riverpod
Future<UsageStats> usageStats(Ref ref) async {
  final fileService = ref.watch(fileServiceProvider);
  final monthStart = DateTime.now().copyWith(day: 1, hour: 0, minute: 0);
  final sinceMs = monthStart.millisecondsSinceEpoch;

  var input = 0;
  var output = 0;
  var cost = 0.0;
  var hits = 0;
  var total = 0;

  for (final file in await fileService.listProjectDbFiles()) {
    if (file.path.endsWith('global.db')) continue;
    final db = LogoiDatabase.atPath(file.path);
    try {
      final rows = await db.aiDao.getUsageSince(sinceMs);
      for (final row in rows) {
        input += row.inputTokens;
        output += row.outputTokens;
        cost += row.costUsd ?? 0;
        total++;
        if (row.cacheHit) hits++;
      }
    } finally {
      await db.close();
    }
  }

  return UsageStats(
    inputTokens: input,
    outputTokens: output,
    estimatedCostUsd: cost,
    cacheHitRate: total > 0 ? hits / total : 0,
  );
}
