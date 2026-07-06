/// Project-level limits for AI throttle and quota guards.
class AIGuardLimits {
  const AIGuardLimits({
    this.maxApiRequestsPerHour = 30,
    this.maxTokensPerDay = 500000,
    this.maxCostUsdPerMonth = 5.0,
    this.minSecondsBetweenCalls = 1.5,
    this.maxCallsPerMinute = 8,
    this.circuitBreakerEnabled = true,
  });

  final int maxApiRequestsPerHour;
  final int maxTokensPerDay;
  final double maxCostUsdPerMonth;
  final double minSecondsBetweenCalls;
  final int maxCallsPerMinute;
  final bool circuitBreakerEnabled;

  factory AIGuardLimits.fromProjectSettings({
    required int maxApiRequestsPerHour,
    required int maxTokensPerDay,
    required double maxCostUsdPerMonth,
    required double minSecondsBetweenCalls,
    required int maxCallsPerMinute,
    required bool circuitBreakerEnabled,
  }) =>
      AIGuardLimits(
        maxApiRequestsPerHour: maxApiRequestsPerHour,
        maxTokensPerDay: maxTokensPerDay,
        maxCostUsdPerMonth: maxCostUsdPerMonth,
        minSecondsBetweenCalls: minSecondsBetweenCalls,
        maxCallsPerMinute: maxCallsPerMinute,
        circuitBreakerEnabled: circuitBreakerEnabled,
      );
}
