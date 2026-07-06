import 'dart:convert';

import '../utils/result.dart';

/// Extracts valid JSON from LLM responses (docs/04_AI_LAYER.md §9.1).
///
/// Fallback chain:
/// 1. Direct parse (response is pure JSON)
/// 2. Strip markdown fences (```json ... ```)
/// 3. Extract first { ... } or [ ... ] block
/// 4. Return AIFailure if everything fails
class JSONResponseParser {
  const JSONResponseParser();

  Result<Map<String, dynamic>, AIFailure> parse(String response) {
    final trimmed = response.trim();

    final direct = _tryDecode(trimmed);
    if (direct != null) return Result.ok(direct);

    final unfenced = _stripFences(trimmed);
    if (unfenced != null) {
      final decoded = _tryDecode(unfenced);
      if (decoded != null) return Result.ok(decoded);
    }

    final block = _extractJsonBlock(trimmed);
    if (block != null) {
      final decoded = _tryDecode(block);
      if (decoded != null) return Result.ok(decoded);
    }

    return const Result.error(AIFailure('Could not parse JSON from AI response'));
  }

  Map<String, dynamic>? _tryDecode(String text) {
    try {
      final decoded = jsonDecode(text);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is List) return {'items': decoded};
      return null;
    } on FormatException {
      return null;
    }
  }

  String? _stripFences(String text) {
    final match =
        RegExp(r'```(?:json)?\s*([\s\S]*?)```', multiLine: true).firstMatch(text);
    return match?.group(1)?.trim();
  }

  /// Finds the first balanced `{...}` or `[...]` block.
  String? _extractJsonBlock(String text) {
    for (final open in ['{', '[']) {
      final close = open == '{' ? '}' : ']';
      final start = text.indexOf(open);
      if (start < 0) continue;
      var depth = 0;
      var inString = false;
      for (var i = start; i < text.length; i++) {
        final char = text[i];
        if (inString) {
          if (char == r'\') {
            i++;
          } else if (char == '"') {
            inString = false;
          }
          continue;
        }
        if (char == '"') inString = true;
        if (char == open) depth++;
        if (char == close) {
          depth--;
          if (depth == 0) return text.substring(start, i + 1);
        }
      }
    }
    return null;
  }
}
