import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../errors.dart';
import '../models.dart';
import '../provider.dart';

/// Shared HTTP logic for providers speaking the OpenAI chat-completions
/// format (OpenRouter and direct OpenAI share >90% of it —
/// docs/07_DEPENDENCIES.md §1.1).
abstract class OpenAICompatibleProvider implements AIProvider {
  OpenAICompatibleProvider({
    required this.apiKey,
    required this.model,
    http.Client? client,
  }) : _client = client ?? http.Client();

  final String apiKey;
  @override
  final String model;
  final http.Client _client;

  Uri get chatCompletionsUri;

  /// Extra headers beyond Authorization/Content-Type (e.g. OpenRouter attribution).
  Map<String, String> get extraHeaders => const {};

  Map<String, String> get _headers => {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
        ...extraHeaders,
      };

  Map<String, dynamic> _body({
    required List<AIChatMessage> messages,
    required double temperature,
    required int maxTokens,
    required bool stream,
    Map<String, dynamic>? responseFormat,
  }) =>
      {
        'model': model,
        'messages': messages.map((m) => m.toOpenAIJson()).toList(),
        'temperature': temperature,
        'max_tokens': maxTokens,
        'stream': stream,
        if (responseFormat != null) 'response_format': responseFormat,
      };

  @override
  Stream<String> streamCompletion({
    required List<AIChatMessage> messages,
    double temperature = 0.7,
    int maxTokens = 2048,
    Map<String, dynamic>? responseFormat,
  }) async* {
    final request = http.Request('POST', chatCompletionsUri)
      ..headers.addAll(_headers)
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
      throw NetworkError('Failed to reach $displayName: $e');
    }

    if (response.statusCode != 200) {
      final body = await response.stream.bytesToString();
      throw mapHttpError(response.statusCode, body, response.headers);
    }

    // SSE parsing: lines prefixed with "data: ", terminated by "data: [DONE]".
    final lines = response.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter());
    await for (final line in lines) {
      if (!line.startsWith('data:')) continue;
      final data = line.substring(5).trim();
      if (data == '[DONE]') return;
      if (data.isEmpty) continue;
      final delta = _extractDelta(data);
      if (delta != null && delta.isNotEmpty) yield delta;
    }
  }

  String? _extractDelta(String data) {
    try {
      final json = jsonDecode(data) as Map<String, dynamic>;
      final choices = json['choices'] as List<dynamic>?;
      if (choices == null || choices.isEmpty) return null;
      final delta = (choices.first as Map<String, dynamic>)['delta'];
      if (delta is Map<String, dynamic>) return delta['content'] as String?;
      return null;
    } on FormatException {
      return null;
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
        chatCompletionsUri,
        headers: _headers,
        body: jsonEncode(_body(
          messages: messages,
          temperature: temperature,
          maxTokens: maxTokens,
          stream: false,
          responseFormat: responseFormat,
        )),
      );
    } catch (e) {
      throw NetworkError('Failed to reach $displayName: $e');
    }

    if (response.statusCode != 200) {
      throw mapHttpError(response.statusCode, response.body, response.headers);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final choices = json['choices'] as List<dynamic>;
    final message =
        (choices.first as Map<String, dynamic>)['message'] as Map<String, dynamic>;
    return message['content'] as String? ?? '';
  }

  @override
  Future<bool> isAvailable() async {
    if (apiKey.isEmpty) return false;
    final models = await listModels().catchError((_) => <AIModel>[]);
    return models.isNotEmpty;
  }

  AIError mapHttpError(int status, String body, Map<String, String> headers) {
    switch (status) {
      case 401:
      case 403:
        return InvalidAPIKeyError('Invalid API key for $displayName',
            providerName: displayName);
      case 402:
        return InsufficientCreditsError('Insufficient credits on $displayName',
            provider: id);
      case 404:
        return ModelUnavailableError('Model $model unavailable on $displayName',
            model: model, provider: id);
      case 413:
        return ContextTooLongError('Context too long',
            currentTokens: 0, maxTokens: 0);
      case 429:
        final retryAfter =
            int.tryParse(headers['retry-after'] ?? '') ?? 10;
        return RateLimitError('Rate limited by $displayName',
            retryAfter: Duration(seconds: retryAfter));
      default:
        return UnknownAIError('$displayName HTTP $status: $body');
    }
  }
}
