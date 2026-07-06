// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mediaSettingsRepository)
final mediaSettingsRepositoryProvider = MediaSettingsRepositoryProvider._();

final class MediaSettingsRepositoryProvider
    extends
        $FunctionalProvider<
          MediaSettingsRepository,
          MediaSettingsRepository,
          MediaSettingsRepository
        >
    with $Provider<MediaSettingsRepository> {
  MediaSettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mediaSettingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mediaSettingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<MediaSettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MediaSettingsRepository create(Ref ref) {
    return mediaSettingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MediaSettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MediaSettingsRepository>(value),
    );
  }
}

String _$mediaSettingsRepositoryHash() =>
    r'8c742dad5eec1f05a684c1b39f801bafd5e82dae';

@ProviderFor(hasYoutubeApiKey)
final hasYoutubeApiKeyProvider = HasYoutubeApiKeyProvider._();

final class HasYoutubeApiKeyProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  HasYoutubeApiKeyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasYoutubeApiKeyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasYoutubeApiKeyHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return hasYoutubeApiKey(ref);
  }
}

String _$hasYoutubeApiKeyHash() => r'5992f54e7bb7b898c668966b3b4719196fdc4fc9';
