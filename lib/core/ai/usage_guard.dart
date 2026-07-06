import '../database/daos/ai_dao.dart';
import 'errors.dart';
import 'guard_limits.dart';

/// Quota guard: hourly requests, daily tokens, monthly cost
/// (docs/05_PROCESSING.md §3.1, docs/06_UI_UX.md §5.2).
class AIUsageGuard {
  AIUsageGuard({
    required AiDao aiDao,
    required String? projectId,
    AIGuardLimits limits = const AIGuardLimits(),
  })  : _aiDao = aiDao,
        _projectId = projectId,
        _limits = limits;

  final AiDao _aiDao;
  final String? _projectId;
  AIGuardLimits _limits;

  void updateLimits(AIGuardLimits limits) => _limits = limits;

  Future<void> checkAllowed() async {
    if (_projectId == null) return;

    final now = DateTime.now();
    final hourAgo = now.subtract(const Duration(hours: 1)).millisecondsSinceEpoch;
    final dayStart =
        DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    final monthStart = DateTime(now.year, now.month).millisecondsSinceEpoch;

    final hourly = await _aiDao.countRequestsSince(
      hourAgo,
      projectId: _projectId,
    );
    if (hourly >= _limits.maxApiRequestsPerHour) {
      throw QuotaExceededError(
        'Limite de ${_limits.maxApiRequestsPerHour} requisições/hora atingido. '
        'Aguarde ou aumente em Configurações.',
      );
    }

    final tokensToday = await _aiDao.sumTokensSince(
      dayStart,
      projectId: _projectId,
    );
    if (tokensToday >= _limits.maxTokensPerDay) {
      throw QuotaExceededError(
        'Limite diário de tokens (${_limits.maxTokensPerDay}) atingido.',
      );
    }

    final costMonth = await _aiDao.sumCostSince(
      monthStart,
      projectId: _projectId,
    );
    if (costMonth >= _limits.maxCostUsdPerMonth) {
      throw QuotaExceededError(
        'Limite mensal de US\$ ${_limits.maxCostUsdPerMonth.toStringAsFixed(2)} '
        'atingido.',
      );
    }
  }

  Future<AIUsageSnapshot> snapshot() async {
    if (_projectId == null) return const AIUsageSnapshot();

    final now = DateTime.now();
    final hourAgo = now.subtract(const Duration(hours: 1)).millisecondsSinceEpoch;
    final dayStart =
        DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    final monthStart = DateTime(now.year, now.month).millisecondsSinceEpoch;

    return AIUsageSnapshot(
      requestsLastHour: await _aiDao.countRequestsSince(
        hourAgo,
        projectId: _projectId,
      ),
      tokensToday: await _aiDao.sumTokensSince(
        dayStart,
        projectId: _projectId,
      ),
      costThisMonth: await _aiDao.sumCostSince(
        monthStart,
        projectId: _projectId,
      ),
      limits: _limits,
    );
  }
}

class AIUsageSnapshot {
  const AIUsageSnapshot({
    this.requestsLastHour = 0,
    this.tokensToday = 0,
    this.costThisMonth = 0,
    this.limits = const AIGuardLimits(),
  });

  final int requestsLastHour;
  final int tokensToday;
  final double costThisMonth;
  final AIGuardLimits limits;

  double get hourlyRatio =>
      limits.maxApiRequestsPerHour == 0
          ? 0
          : requestsLastHour / limits.maxApiRequestsPerHour;

  double get dailyTokenRatio =>
      limits.maxTokensPerDay == 0 ? 0 : tokensToday / limits.maxTokensPerDay;

  double get monthlyCostRatio =>
      limits.maxCostUsdPerMonth == 0
          ? 0
          : costThisMonth / limits.maxCostUsdPerMonth;

  bool get isNearLimit =>
      hourlyRatio >= 0.8 ||
      dailyTokenRatio >= 0.8 ||
      monthlyCostRatio >= 0.8;
}
