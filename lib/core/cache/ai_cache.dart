import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database/daos/ai_dao.dart';
import '../database/database.dart';

/// AI response cache (docs/05_PROCESSING.md §8).
///
/// Cache key = hash(mode + prompt_version + input_hash + model).
/// Never expires (PDF text does not change); invalidated when the
/// prompt version changes. Chat and Socratic mode are NOT cached.
class AICacheStrategy {
  AICacheStrategy(this._dao);

  final AiDao _dao;
  static const _uuid = Uuid();

  static String inputHash(String input) =>
      sha256.convert(utf8.encode(input)).toString();

  static String cacheKey({
    required String mode,
    required String promptVersion,
    required String inputHash,
    required String model,
  }) =>
      sha256
          .convert(utf8.encode('$mode|$promptVersion|$inputHash|$model'))
          .toString();

  Future<String?> lookup({
    required String mode,
    required String promptVersion,
    required String input,
    required String model,
  }) async {
    final key = cacheKey(
      mode: mode,
      promptVersion: promptVersion,
      inputHash: inputHash(input),
      model: model,
    );
    final row = await _dao.getCached(key);
    if (row == null) return null;
    await _dao.touchCache(key);
    return row.response;
  }

  Future<void> store({
    required String mode,
    required String promptVersion,
    required String input,
    required String provider,
    required String model,
    required String response,
    int? inputTokens,
    int? outputTokens,
  }) async {
    final hash = inputHash(input);
    final now = DateTime.now().millisecondsSinceEpoch;
    await _dao.insertCache(AiResponseCacheCompanion(
      id: Value(_uuid.v4()),
      cacheKey: Value(cacheKey(
        mode: mode,
        promptVersion: promptVersion,
        inputHash: hash,
        model: model,
      )),
      inputHash: Value(hash),
      aiMode: Value(mode),
      promptVersion: Value(promptVersion),
      provider: Value(provider),
      model: Value(model),
      response: Value(response),
      inputTokens: Value(inputTokens),
      outputTokens: Value(outputTokens),
      createdAt: Value(now),
      lastUsedAt: Value(now),
    ));
  }

  /// User-forced regeneration.
  Future<void> invalidate({
    required String mode,
    required String promptVersion,
    required String input,
    required String model,
  }) =>
      _dao.invalidateByKey(cacheKey(
        mode: mode,
        promptVersion: promptVersion,
        inputHash: inputHash(input),
        model: model,
      ));
}
