import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/database/daos/ai_dao.dart';
import '../../../core/database/database.dart';
import '../../../core/services/secure_storage.dart';
import '../../../core/utils/result.dart';

/// Known provider IDs (docs/03_DATABASE.md §3.16).
class KnownProviders {
  static const openrouter = 'openrouter';
  static const openai = 'openai';
  static const anthropic = 'anthropic';
  static const google = 'google';
  static const ollama = 'ollama';

  static const all = [openrouter, openai, anthropic, google, ollama];

  static String displayName(String id) => switch (id) {
        openrouter => 'OpenRouter',
        openai => 'OpenAI (Direto)',
        anthropic => 'Anthropic (Direto)',
        google => 'Google (Direto)',
        ollama => 'Ollama (Local)',
        _ => id,
      };

  /// Providers that need an API key (Ollama does not).
  static bool needsApiKey(String id) => id != ollama;
}

/// Global AI provider configuration. Non-sensitive settings live in the
/// global database; API keys go exclusively to secure storage.
class AiSettingsRepository {
  AiSettingsRepository({
    required AiDao globalAiDao,
    required SecureStorageService secureStorage,
  })  : _dao = globalAiDao,
        _storage = secureStorage;

  final AiDao _dao;
  final SecureStorageService _storage;

  Stream<List<AiProviderRow>> watchProviders() => _dao.watchProviders();

  Future<List<AiProviderRow>> getProviders() => _dao.getProviders();

  Future<AiProviderRow?> getProvider(String id) => _dao.getProvider(id);

  Future<bool> hasApiKey(String providerId) => _storage.hasApiKey(providerId);

  Future<String?> getApiKey(String providerId) => _storage.readApiKey(providerId);

  Future<Result<void, Failure>> configureProvider({
    required String providerId,
    String? apiKey,
    String? baseUrl,
    List<String>? preferredModels,
    bool isActive = true,
  }) async {
    try {
      if (apiKey != null && apiKey.isNotEmpty) {
        await _storage.writeApiKey(providerId, apiKey);
      }
      await _dao.upsertProvider(AiProvidersCompanion(
        id: Value(providerId),
        name: Value(KnownProviders.displayName(providerId)),
        isActive: Value(isActive),
        baseUrl: Value(baseUrl),
        models: Value(
          preferredModels != null ? jsonEncode(preferredModels) : null,
        ),
      ));
      return const Result.ok(null);
    } catch (e) {
      return Result.error(DatabaseFailure('Falha ao configurar provider: $e'));
    }
  }

  Future<Result<void, Failure>> removeProvider(String providerId) async {
    try {
      await _storage.deleteApiKey(providerId);
      await _dao.upsertProvider(AiProvidersCompanion(
        id: Value(providerId),
        name: Value(KnownProviders.displayName(providerId)),
        isActive: const Value(false),
      ));
      return const Result.ok(null);
    } catch (e) {
      return Result.error(DatabaseFailure('Falha ao remover provider: $e'));
    }
  }
}
