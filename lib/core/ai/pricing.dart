/// Rough per-model pricing (USD per 1M tokens) for cost dashboard and
/// quota guards. Values are estimates; OpenRouter models vary by route.
abstract final class ModelPricing {
  static const _defaultInputPerM = 1.0;
  static const _defaultOutputPerM = 3.0;

  static const _byModel = <String, (double input, double output)>{
    'anthropic/claude-sonnet-4-6': (3.0, 15.0),
    'anthropic/claude-haiku-4-5': (0.8, 4.0),
    'gpt-4o': (2.5, 10.0),
    'gpt-4o-mini': (0.15, 0.6),
    'claude-sonnet-4-20250514': (3.0, 15.0),
    'claude-haiku-3-5-20241022': (0.8, 4.0),
  };

  static double estimateCostUsd({
    required String model,
    required int inputTokens,
    required int outputTokens,
  }) {
    final rates = _byModel[model] ?? (_defaultInputPerM, _defaultOutputPerM);
    return (inputTokens * rates.$1 + outputTokens * rates.$2) / 1e6;
  }
}
