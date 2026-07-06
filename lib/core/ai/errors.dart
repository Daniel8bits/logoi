/// AI error taxonomy (docs/04_AI_LAYER.md §10).
sealed class AIError {
  const AIError(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Retry automatically after [retryAfter] with visual feedback.
class RateLimitError extends AIError {
  const RateLimitError(super.message, {required this.retryAfter});
  final Duration retryAfter;
}

/// Trigger RAGContextBuilder with a smaller K and retry.
class ContextTooLongError extends AIError {
  const ContextTooLongError(
    super.message, {
    required this.currentTokens,
    required this.maxTokens,
  });
  final int currentTokens;
  final int maxTokens;
}

/// Navigate the user to the provider settings screen.
class InvalidAPIKeyError extends AIError {
  const InvalidAPIKeyError(super.message, {required this.providerName});
  final String providerName;
}

/// Offer retry or offline mode.
class NetworkError extends AIError {
  const NetworkError(super.message);
}

/// Suggest alternative models (or OpenRouter auto-routing).
class ModelUnavailableError extends AIError {
  const ModelUnavailableError(
    super.message, {
    required this.model,
    required this.provider,
  });
  final String model;
  final String provider;
}

/// Inform user; suggest another provider or Ollama.
class InsufficientCreditsError extends AIError {
  const InsufficientCreditsError(super.message, {required this.provider});
  final String provider;
}

/// Show raw response with retry option.
class AIParseError extends AIError {
  const AIParseError(super.message, {required this.rawResponse});
  final String rawResponse;
}

/// Generic unexpected provider error.
class UnknownAIError extends AIError {
  const UnknownAIError(super.message);
}

/// Local quota exceeded (hourly/daily/monthly project limits).
class QuotaExceededError extends AIError {
  const QuotaExceededError(super.message);
}

/// Anti-loop throttle: burst, min interval, circuit breaker, concurrency.
class ThrottleExceededError extends AIError {
  const ThrottleExceededError(super.message, {this.retryAfter});
  final Duration? retryAfter;
}
