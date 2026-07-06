// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idle_detector_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(idleDetector)
final idleDetectorProvider = IdleDetectorProvider._();

final class IdleDetectorProvider
    extends $FunctionalProvider<IdleDetector, IdleDetector, IdleDetector>
    with $Provider<IdleDetector> {
  IdleDetectorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'idleDetectorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$idleDetectorHash();

  @$internal
  @override
  $ProviderElement<IdleDetector> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IdleDetector create(Ref ref) {
    return idleDetector(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IdleDetector value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IdleDetector>(value),
    );
  }
}

String _$idleDetectorHash() => r'd66822f72a4add31d88321ba3766c3a2e723d837';

@ProviderFor(isUserIdle)
final isUserIdleProvider = IsUserIdleProvider._();

final class IsUserIdleProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsUserIdleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isUserIdleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isUserIdleHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isUserIdle(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isUserIdleHash() => r'b49f6141999a996aa625848a2ef1829bf1d02bd2';
