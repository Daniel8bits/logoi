import 'dart:convert';

import 'package:http/http.dart' as http;

/// Ollama client for local embeddings, detection and health check
/// (docs/05_PROCESSING.md §9.3). If unavailable, embedding features
/// degrade silently and the UI shows a subtle offline indicator.
class OllamaService {
  OllamaService({
    this.baseUrl = 'http://localhost:11434',
    http.Client? client,
  }) : _client = client ?? http.Client();

  final String baseUrl;
  final http.Client _client;

  static const defaultEmbeddingModel = 'nomic-embed-text';

  /// Connects to localhost:11434 with a 2s timeout.
  Future<bool> isAvailable() async {
    try {
      final response = await _client
          .get(Uri.parse('$baseUrl/api/tags'))
          .timeout(const Duration(seconds: 2));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// Installed models via GET /api/tags.
  Future<List<String>> listModels() async {
    try {
      final response = await _client
          .get(Uri.parse('$baseUrl/api/tags'))
          .timeout(const Duration(seconds: 2));
      if (response.statusCode != 200) return const [];
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final models = json['models'] as List<dynamic>? ?? const [];
      return models
          .cast<Map<String, dynamic>>()
          .map((m) => m['name'] as String)
          .toList();
    } catch (_) {
      return const [];
    }
  }

  /// Generates an embedding for [text]. Returns null when Ollama is offline.
  Future<List<double>?> embed(
    String text, {
    String model = defaultEmbeddingModel,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/api/embeddings'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'model': model, 'prompt': text}),
      );
      if (response.statusCode != 200) return null;
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final embedding = json['embedding'] as List<dynamic>?;
      return embedding?.cast<num>().map((n) => n.toDouble()).toList();
    } catch (_) {
      return null;
    }
  }
}
