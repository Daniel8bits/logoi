import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models.dart';
import 'openai_compatible_provider.dart';

/// Direct OpenAI API (docs/04_AI_LAYER.md §2.2).
class DirectOpenAIProvider extends OpenAICompatibleProvider {
  DirectOpenAIProvider({
    required super.apiKey,
    required super.model,
    super.client,
  });

  static const _baseUrl = 'https://api.openai.com/v1';

  @override
  String get id => 'openai';

  @override
  String get displayName => 'OpenAI';

  @override
  Uri get chatCompletionsUri => Uri.parse('$_baseUrl/chat/completions');

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
        .map((m) => AIModel(id: m['id'] as String, name: m['id'] as String))
        .toList();
  }
}
