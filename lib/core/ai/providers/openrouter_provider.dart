import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models.dart';
import 'openai_compatible_provider.dart';

/// OpenRouter gateway (docs/04_AI_LAYER.md §2.1).
class OpenRouterProvider extends OpenAICompatibleProvider {
  OpenRouterProvider({
    required super.apiKey,
    required super.model,
    super.client,
  });

  static const _baseUrl = 'https://openrouter.ai/api/v1';

  @override
  String get id => 'openrouter';

  @override
  String get displayName => 'OpenRouter';

  @override
  Uri get chatCompletionsUri => Uri.parse('$_baseUrl/chat/completions');

  @override
  Map<String, String> get extraHeaders => const {
        'HTTP-Referer': 'logoi-reader',
        'X-Title': 'Logoi',
      };

  @override
  Future<List<AIModel>> listModels() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/models'),
      headers: {'Authorization': 'Bearer $apiKey'},
    );
    if (response.statusCode != 200) {
      throw mapHttpError(response.statusCode, response.body, response.headers);
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = json['data'] as List<dynamic>;
    return data
        .cast<Map<String, dynamic>>()
        .map((m) => AIModel(
              id: m['id'] as String,
              name: (m['name'] as String?) ?? (m['id'] as String),
              contextLength: (m['context_length'] as num?)?.toInt(),
            ))
        .toList();
  }
}
