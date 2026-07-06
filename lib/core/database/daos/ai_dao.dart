import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/ai_tables.dart';

part 'ai_dao.drift.dart';

@DriftAccessor(tables: [AiProviders, AiResponseCache, ApiUsageLog])
class AiDao extends DatabaseAccessor<LogoiDatabase> with _$AiDaoMixin {
  AiDao(super.db);

  // ── Provider configuration ──

  Future<List<AiProviderRow>> getProviders() => select(aiProviders).get();

  Stream<List<AiProviderRow>> watchProviders() => select(aiProviders).watch();

  Future<AiProviderRow?> getProvider(String id) =>
      (select(aiProviders)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> upsertProvider(AiProvidersCompanion entry) =>
      into(aiProviders).insertOnConflictUpdate(entry);

  // ── Response cache ──

  Future<AiResponseCacheRow?> getCached(String cacheKey) =>
      (select(aiResponseCache)..where((t) => t.cacheKey.equals(cacheKey)))
          .getSingleOrNull();

  Future<void> insertCache(AiResponseCacheCompanion entry) =>
      into(aiResponseCache).insert(entry, mode: InsertMode.insertOrReplace);

  Future<void> touchCache(String cacheKey) async {
    final row = await getCached(cacheKey);
    if (row == null) return;
    await (update(aiResponseCache)..where((t) => t.cacheKey.equals(cacheKey)))
        .write(AiResponseCacheCompanion(
      lastUsedAt: Value(DateTime.now().millisecondsSinceEpoch),
      useCount: Value(row.useCount + 1),
    ));
  }

  Future<void> invalidateByKey(String cacheKey) =>
      (delete(aiResponseCache)..where((t) => t.cacheKey.equals(cacheKey))).go();

  // ── Usage log ──

  Future<void> logUsage(ApiUsageLogCompanion entry) =>
      into(apiUsageLog).insert(entry);

  Future<List<ApiUsageLogRow>> getUsageSince(int sinceMs) =>
      (select(apiUsageLog)
            ..where((t) => t.calledAt.isBiggerOrEqualValue(sinceMs))
            ..orderBy([(t) => OrderingTerm.desc(t.calledAt)]))
          .get();

  Future<int> countRequestsSince(int sinceMs, {String? projectId}) async {
    final countExp = apiUsageLog.id.count();
    final query = selectOnly(apiUsageLog)..addColumns([countExp]);
    query.where(apiUsageLog.calledAt.isBiggerOrEqualValue(sinceMs) &
        apiUsageLog.cacheHit.equals(false));
    if (projectId != null) {
      query.where(apiUsageLog.projectId.equals(projectId));
    }
    final row = await query.getSingle();
    return row.read(countExp) ?? 0;
  }

  Future<int> sumTokensSince(int sinceMs, {String? projectId}) async {
    final sumIn = apiUsageLog.inputTokens.sum();
    final sumOut = apiUsageLog.outputTokens.sum();
    final query = selectOnly(apiUsageLog)
      ..addColumns([sumIn, sumOut]);
    query.where(apiUsageLog.calledAt.isBiggerOrEqualValue(sinceMs) &
        apiUsageLog.cacheHit.equals(false));
    if (projectId != null) {
      query.where(apiUsageLog.projectId.equals(projectId));
    }
    final row = await query.getSingle();
    return (row.read(sumIn) ?? 0) + (row.read(sumOut) ?? 0);
  }

  Future<double> sumCostSince(int sinceMs, {String? projectId}) async {
    final sumCost = apiUsageLog.costUsd.sum();
    final query = selectOnly(apiUsageLog)..addColumns([sumCost]);
    query.where(apiUsageLog.calledAt.isBiggerOrEqualValue(sinceMs) &
        apiUsageLog.cacheHit.equals(false));
    if (projectId != null) {
      query.where(apiUsageLog.projectId.equals(projectId));
    }
    final row = await query.getSingle();
    return row.read(sumCost) ?? 0;
  }
}
