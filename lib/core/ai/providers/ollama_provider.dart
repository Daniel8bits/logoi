import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../errors.dart';
import '../models.dart';
import '../provider.dart';

/// Local text generation via Ollama (docs/04_AI_LAYER.md §2.5).
/// Embeddings live in OllamaService, not here.
class OllamaProvider implements AIProvider {
  OllamaProvider({
    required this.model,
    this.baseUrl = 'http://localhost:11434',
    http.Client? client,
  }) : _client = client ?? http.Client();

  final String baseUrl;
  @override
  final String model;
  final http.Client _client;

  @override
  String get id => 'ollama';

  @override
  String get displayName => 'Ollama (local)';

  Map<String, dynamic> _body({
    required List<AIChatMessage> messages,
    required double temperature,
    required int maxTokens,
    required bool stream,
    Map<String, dynamic>? responseFormat,
  }) =>
      {
        'model': model,
        'messages': messages
            .map((m) => {'role': m.role.name, 'content': m.content})
            .toList(),
        'stream': stream,
        'options': {'temperature': temperature, 'num_predict': maxTokens},
        if (responseFormat != null && responseFormat['type'] == 'json_schema')
          'format': (responseFormat['json_schema']
              as Map<String, dynamic>?)?['schema'],
      };

  @override
  Stream<String> streamCompletion({
    required List<AIChatMessage> messages,
    double temperature = 0.7,
    int maxTokens = 2048,
    Map<String, dynamic>? responseFormat,
  }) async* {
    final request = http.Request('POST', Uri.parse('$baseUrl/api/chat'))
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode(_body(
        messages: messages,
        temperature: temperature,
        maxTokens: maxTokens,
        stream: true,
        responseFormat: responseFormat,
      ));

    final http.StreamedResponse response;
    try {
      response = await _client.send(request);
    } catch (e) {
      throw NetworkError('Ollama unreachable at $baseUrl: $e');
    }
    if (response.statusCode != 200) {
      final body = await response.stream.bytesToString();
      throw UnknownAIError('Ollama HTTP ${response.statusCode}: $body');
    }

    // Ollama streams newline-delimited JSON objects.
    final lines = response.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter());
    await for (final line in lines) {
      if (line.trim().isEmpty) continue;
      final Map<String, dynamic> json;
      try {
        json = jsonDecode(line) as Map<String, dynamic>;
      } on FormatException {
        continue;
      }
      final message = json['message'] as Map<String, dynamic>?;
      final content = message?['content'] as String?;
      if (content != null && content.isNotEmpty) yield content;
      if (json['done'] == true) return;
    }
  }

  @override
  Future<String> complete({
    required List<AIChatMessage> messages,
    double temperature = 0.3,
    int maxTokens = 4096,
    Map<String, dynamic>? responseFormat,
  }) async {
    final http.Response response;
    try {
      response = await _client.post(
        Uri.parse('$baseUrl/api/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(_body(
          messages: messages,
          temperature: temperature,
          maxTokens: maxTokens,
          stream: false,
          responseFormat: responseFormat,
        )),
      );
    } catch (e) {
      throw NetworkError('Ollama unreachable at $baseUrl: $e');
    }
    if (response.statusCode != 200) {
      throw UnknownAIError('Ollama HTTP ${response.statusCode}: ${response.body}');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final message = json['message'] as Map<String, dynamic>?;
    return message?['content'] as String? ?? '';
  }

  @override
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

  @override
  Future<List<AIModel>> listModels() async {
    final response = await _client.get(Uri.parse('$baseUrl/api/tags'));
    if (response.statusCode != 200) return const [];
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final models = json['models'] as List<dynamic>? ?? const [];
    return models
        .cast<Map<String, dynamic>>()
        .map((m) => AIModel(id: m['name'] as String, name: m['name'] as String))
        .toList();
  }
}
