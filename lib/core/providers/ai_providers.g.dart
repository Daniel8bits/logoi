// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Global database — holds only app-level AI provider configuration
/// (docs/03_DATABASE.md §4: ai_providers is global, not per project).

@ProviderFor(globalDatabase)
final globalDatabaseProvider = GlobalDatabaseProvider._();

/// Global database — holds only app-level AI provider configuration
/// (docs/03_DATABASE.md §4: ai_providers is global, not per project).

final class GlobalDatabaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<LogoiDatabase>,
          LogoiDatabase,
          FutureOr<LogoiDatabase>
        >
    with $FutureModifier<LogoiDatabase>, $FutureProvider<LogoiDatabase> {
  /// Global database — holds only app-level AI provider configuration
  /// (docs/03_DATABASE.md §4: ai_providers is global, not per project).
  GlobalDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalDatabaseHash();

  @$internal
  @override
  $FutureProviderElement<LogoiDatabase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LogoiDatabase> create(Ref ref) {
    return globalDatabase(ref);
  }
}

String _$globalDatabaseHash() => r'fb8091e394c2445674bbfa7098767337cdf3b65a';

@ProviderFor(aiSettingsRepository)
final aiSettingsRepositoryProvider = AiSettingsRepositoryProvider._();

final class AiSettingsRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<AiSettingsRepository>,
          AiSettingsRepository,
          FutureOr<AiSettingsRepository>
        >
    with
        $FutureModifier<AiSettingsRepository>,
        $FutureProvider<AiSettingsRepository> {
  AiSettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiSettingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiSettingsRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<AiSettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AiSettingsRepository> create(Ref ref) {
    return aiSettingsRepository(ref);
  }
}

String _$aiSettingsRepositoryHash() =>
    r'318d1e4469005c9c5c9abc475fbc4c7af889a610';

/// Per-project throttler (in-memory, reset when project closes).

@ProviderFor(ProjectThrottler)
final projectThrottlerProvider = ProjectThrottlerProvider._();

/// Per-project throttler (in-memory, reset when project closes).
final class ProjectThrottlerProvider
    extends $NotifierProvider<ProjectThrottler, AIRequestThrottler?> {
  /// Per-project throttler (in-memory, reset when project closes).
  ProjectThrottlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectThrottlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectThrottlerHash();

  @$internal
  @override
  ProjectThrottler create() => ProjectThrottler();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AIRequestThrottler? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AIRequestThrottler?>(value),
    );
  }
}

String _$projectThrottlerHash() => r'54132b2ad82afcd8b7a9ad4af512aeebab21ff1e';

/// Per-project throttler (in-memory, reset when project closes).

abstract class _$ProjectThrottler extends $Notifier<AIRequestThrottler?> {
  AIRequestThrottler? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AIRequestThrottler?, AIRequestThrottler?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AIRequestThrottler?, AIRequestThrottler?>,
              AIRequestThrottler?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Usage quota snapshot for the open project dashboard.

@ProviderFor(aiUsageSnapshot)
final aiUsageSnapshotProvider = AiUsageSnapshotProvider._();

/// Usage quota snapshot for the open project dashboard.

final class AiUsageSnapshotProvider
    extends
        $FunctionalProvider<
          AsyncValue<AIUsageSnapshot?>,
          AIUsageSnapshot?,
          FutureOr<AIUsageSnapshot?>
        >
    with $FutureModifier<AIUsageSnapshot?>, $FutureProvider<AIUsageSnapshot?> {
  /// Usage quota snapshot for the open project dashboard.
  AiUsageSnapshotProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiUsageSnapshotProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiUsageSnapshotHash();

  @$internal
  @override
  $FutureProviderElement<AIUsageSnapshot?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AIUsageSnapshot?> create(Ref ref) {
    return aiUsageSnapshot(ref);
  }
}

String _$aiUsageSnapshotHash() => r'765687de2d71a007f314ed3dafc158ce33eb0740';

/// AIRouter for the currently open project. Null when no project is open.

@ProviderFor(aiRouter)
final aiRouterProvider = AiRouterProvider._();

/// AIRouter for the currently open project. Null when no project is open.

final class AiRouterProvider
    extends
        $FunctionalProvider<
          AsyncValue<AIRouter?>,
          AIRouter?,
          FutureOr<AIRouter?>
        >
    with $FutureModifier<AIRouter?>, $FutureProvider<AIRouter?> {
  /// AIRouter for the currently open project. Null when no project is open.
  AiRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiRouterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiRouterHash();

  @$internal
  @override
  $FutureProviderElement<AIRouter?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AIRouter?> create(Ref ref) {
    return aiRouter(ref);
  }
}

String _$aiRouterHash() => r'301f9337a041f120b5dd53b70e54c9ffce323628';
