import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Wrapper over flutter_secure_storage for API keys
/// (docs/02_ARCHITECTURE.md §6.1). Keys are never persisted in SQLite,
/// SharedPreferences or plain files.
class SecureStorageService {
  SecureStorageService([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static String _apiKeyKey(String providerId) => 'api_key_$providerId';

  static const youtubeApiKey = 'media_youtube_api_key';
  static const mapsApiKey = 'media_maps_api_key';
  static const googleCseKey = 'media_google_cse_key';
  static const googleCseId = 'media_google_cse_id';

  Future<String?> readApiKey(String providerId) =>
      _storage.read(key: _apiKeyKey(providerId));

  Future<void> writeApiKey(String providerId, String apiKey) =>
      _storage.write(key: _apiKeyKey(providerId), value: apiKey);

  Future<void> deleteApiKey(String providerId) =>
      _storage.delete(key: _apiKeyKey(providerId));

  Future<bool> hasApiKey(String providerId) async =>
      (await readApiKey(providerId))?.isNotEmpty ?? false;

  Future<String?> read(String key) => _storage.read(key: key);

  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  Future<bool> has(String key) async =>
      (await read(key))?.isNotEmpty ?? false;
}
