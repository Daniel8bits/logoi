import '../../../core/services/secure_storage.dart';

/// External media API keys (YouTube, Maps, Google CSE).
class MediaSettingsRepository {
  MediaSettingsRepository(this._storage);

  final SecureStorageService _storage;

  Future<String?> youtubeApiKey() => _storage.read(SecureStorageService.youtubeApiKey);
  Future<void> setYoutubeApiKey(String key) =>
      _storage.write(SecureStorageService.youtubeApiKey, key);

  Future<String?> mapsApiKey() => _storage.read(SecureStorageService.mapsApiKey);
  Future<void> setMapsApiKey(String key) =>
      _storage.write(SecureStorageService.mapsApiKey, key);

  Future<String?> googleCseKey() => _storage.read(SecureStorageService.googleCseKey);
  Future<void> setGoogleCseKey(String key) =>
      _storage.write(SecureStorageService.googleCseKey, key);

  Future<String?> googleCseId() => _storage.read(SecureStorageService.googleCseId);
  Future<void> setGoogleCseId(String id) =>
      _storage.write(SecureStorageService.googleCseId, id);

  Future<bool> hasYoutubeKey() => _storage.has(SecureStorageService.youtubeApiKey);
}
