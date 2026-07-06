import 'models.dart';

/// Abstract interface implemented by every AI backend
/// (docs/02_ARCHITECTURE.md §4.2).
///
/// Note: `embed()` is intentionally NOT part of this interface — embeddings
/// are the exclusive responsibility of `OllamaService`.
abstract class AIProvider {
  /// 'openrouter', 'openai', 'anthropic', 'google', 'ollama'
  String get id;

  String get displayName;

  String get model;

  /// Streaming response (chat, explanations).
  Stream<String> streamCompletion({
    required List<AIChatMessage> messages,
    double temperature = 0.7,
    int maxTokens = 2048,
    Map<String, dynamic>? responseFormat,
  });

  /// Complete response (batch operations).
  Future<String> complete({
    required List<AIChatMessage> messages,
    double temperature = 0.3,
    int maxTokens = 4096,
    Map<String, dynamic>? responseFormat,
  });

  /// Whether the provider is configured and reachable.
  Future<bool> isAvailable();

  /// Available models (OpenRouter: API list; Ollama: installed models).
  Future<List<AIModel>> listModels();
}
