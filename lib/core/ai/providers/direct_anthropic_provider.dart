import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../errors.dart';
import '../models.dart';
import '../provider.dart';

/// Direct Anthropic Messages API (docs/04_AI_LAYER.md §2.3).
class DirectAnthropicProvider implements AIProvider {
  DirectAnthropicProvider({
    required this.apiKey,
    required this.model,
    http.Client? client,
  }) : _client = client ?? http.Client();

  static const _baseUrl = 'https://api.anthropic.com/v1';
  static const _apiVersion = '2023-06-01';

  final String apiKey;
  @override
  final String model;
  final http.Client _client;

  @override
  String get id => 'anthropic';

  @override
  String get displayName => 'Anthropic';

  Map<String, String> get _headers => {
        'x-api-key': apiKey,
        'anthropic-version': _apiVersion,
        'Content-Type': 'application/json',
      };

  /// The Messages API takes the system prompt as a top-level field.
  Map<String, dynamic> _body({
    required List<AIChatMessage> messages,
    required double temperature,
    required int maxTokens,
    required bool stream,
  }) {
    final system = messages
        .where((m) => m.role == AIChatRole.system)
        .map((m) => m.content)
        .join('\n\n');
    final turns = messages
        .where((m) => m.role != AIChatRole.system)
        .map((m) => {'role': m.role.name, 'content': m.content})
        .toList();
    return {
      'model': model,
      if (system.isNotEmpty) 'system': system,
      'messages': turns,
      'temperature': temperature,
      'max_tokens': maxTokens,
      'stream': stream,
    };
  }

  @override
  Stream<String> streamCompletion({
    required List<AIChatMessage> messages,
    double temperature = 0.7,
    int maxTokens = 2048,
    Map<String, dynamic>? responseFormat,
  }) async* {
    final request = http.Request('POST', Uri.parse('$_baseUrl/messages'))
      ..headers.addAll(_headers)
      ..body = jsonEncode(_body(
        messages: messages,
        temperature: temperature,
        maxTokens: maxTokens,
        stream: true,
      ));

    final http.StreamedResponse response;
    try {
      response = await _client.send(request);
    } catch (e) {
      throw NetworkError('Failed to reach Anthropic: $e');
    }

    if (response.statusCode != 200) {
      final body = await response.stream.bytesToString();
      throw _mapError(response.statusCode, body, response.headers);
    }

    final lines = response.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter());
    await for (final line in lines) {
      if (!line.startsWith('data:')) continue;
      final data = line.substring(5).trim();
      if (data.isEmpty) continue;
      final Map<String, dynamic> json;
      try {
        json = jsonDecode(data) as Map<String, dynamic>;
      } on FormatException {
        continue;
      }
      if (json['type'] == 'content_block_delta') {
        final delta = json['delta'] as Map<String, dynamic>?;
        final text = delta?['text'] as String?;
        if (text != null && text.isNotEmpty) yield text;
      }
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
        Uri.parse('$_baseUrl/messages'),
        headers: _headers,
        body: jsonEncode(_body(
          messages: messages,
          temperature: temperature,
          maxTokens: maxTokens,
          stream: false,
        )),
      );
    } catch (e) {
      throw NetworkError('Failed to reach Anthropic: $e');
    }

    if (response.statusCode != 200) {
      throw _mapError(response.statusCode, response.body, response.headers);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final content = json['content'] as List<dynamic>;
    return content
        .cast<Map<String, dynamic>>()
        .where((b) => b['type'] == 'text')
        .map((b) => b['text'] as String)
        .join();
  }

  @override
  Future<bool> isAvailable() async {
    if (apiKey.isEmpty) return false;
    try {
      await complete(
        messages: const [AIChatMessage(role: AIChatRole.user, content: 'ping')],
        maxTokens: 1,
      );
      return true;
    } on AIError catch (e) {
      return e is! InvalidAPIKeyError && e is! NetworkError;
    }
  }

  @override
  Future<List<AIModel>> listModels() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/models'),
      headers: _headers,
    );
    if (response.statusCode != 200) {
      throw _mapError(response.statusCode, response.body, response.headers);
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = json['data'] as List<dynamic>;
    return data
        .cast<Map<String, dynamic>>()
        .map((m) => AIModel(
              id: m['id'] as String,
              name: (m['display_name'] as String?) ?? (m['id'] as String),
            ))
        .toList();
  }

  AIError _mapError(int status, String body, Map<String, String> headers) {
    switch (status) {
      case 401:
      case 403:
        return InvalidAPIKeyError('Invalid Anthropic API key',
            providerName: displayName);
      case 404:
        return ModelUnavailableError('Model $model unavailable',
            model: model, provider: id);
      case 429:
        final retryAfter = int.tryParse(headers['retry-after'] ?? '') ?? 10;
        return RateLimitError('Rate limited by Anthropic',
            retryAfter: Duration(seconds: retryAfter));
      default:
        return UnknownAIError('Anthropic HTTP $status: $body');
    }
  }
}
