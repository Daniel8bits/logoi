// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(aiProviderConfigs)
final aiProviderConfigsProvider = AiProviderConfigsProvider._();

final class AiProviderConfigsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AiProviderRow>>,
          List<AiProviderRow>,
          Stream<List<AiProviderRow>>
        >
    with
        $FutureModifier<List<AiProviderRow>>,
        $StreamProvider<List<AiProviderRow>> {
  AiProviderConfigsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiProviderConfigsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiProviderConfigsHash();

  @$internal
  @override
  $StreamProviderElement<List<AiProviderRow>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<AiProviderRow>> create(Ref ref) {
    return aiProviderConfigs(ref);
  }
}

String _$aiProviderConfigsHash() => r'3e8856cbb064ec377867cedd94b54a0484e654f0';

@ProviderFor(providerHasKey)
final providerHasKeyProvider = ProviderHasKeyFamily._();

final class ProviderHasKeyProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  ProviderHasKeyProvider._({
    required ProviderHasKeyFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'providerHasKeyProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$providerHasKeyHash();

  @override
  String toString() {
    return r'providerHasKeyProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as String;
    return providerHasKey(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProviderHasKeyProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$providerHasKeyHash() => r'0f942d5129671dd11e8aaf5149eb6efb1fff2536';

final class ProviderHasKeyFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, String> {
  ProviderHasKeyFamily._()
    : super(
        retry: null,
        name: r'providerHasKeyProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProviderHasKeyProvider call(String providerId) =>
      ProviderHasKeyProvider._(argument: providerId, from: this);

  @override
  String toString() => r'providerHasKeyProvider';
}

@ProviderFor(usageStats)
final usageStatsProvider = UsageStatsProvider._();

final class UsageStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<UsageStats>,
          UsageStats,
          FutureOr<UsageStats>
        >
    with $FutureModifier<UsageStats>, $FutureProvider<UsageStats> {
  UsageStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usageStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usageStatsHash();

  @$internal
  @override
  $FutureProviderElement<UsageStats> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<UsageStats> create(Ref ref) {
    return usageStats(ref);
  }
}

String _$usageStatsHash() => r'23a33d5e88ce5bf1d088224abe0a050d50e6b6fc';
