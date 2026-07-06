// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'processing_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(embeddingIndexer)
final embeddingIndexerProvider = EmbeddingIndexerProvider._();

final class EmbeddingIndexerProvider
    extends
        $FunctionalProvider<
          EmbeddingIndexer?,
          EmbeddingIndexer?,
          EmbeddingIndexer?
        >
    with $Provider<EmbeddingIndexer?> {
  EmbeddingIndexerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'embeddingIndexerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$embeddingIndexerHash();

  @$internal
  @override
  $ProviderElement<EmbeddingIndexer?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EmbeddingIndexer? create(Ref ref) {
    return embeddingIndexer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmbeddingIndexer? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmbeddingIndexer?>(value),
    );
  }
}

String _$embeddingIndexerHash() => r'f81c05905f17caf94f541189a6fb0a36355a651c';

@ProviderFor(semanticSearchService)
final semanticSearchServiceProvider = SemanticSearchServiceProvider._();

final class SemanticSearchServiceProvider
    extends
        $FunctionalProvider<
          SemanticSearchService?,
          SemanticSearchService?,
          SemanticSearchService?
        >
    with $Provider<SemanticSearchService?> {
  SemanticSearchServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'semanticSearchServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$semanticSearchServiceHash();

  @$internal
  @override
  $ProviderElement<SemanticSearchService?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SemanticSearchService? create(Ref ref) {
    return semanticSearchService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SemanticSearchService? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SemanticSearchService?>(value),
    );
  }
}

String _$semanticSearchServiceHash() =>
    r'd36c2e1f3775d5e8871d1a67b42e691090fdd71e';

@ProviderFor(hybridSearchService)
final hybridSearchServiceProvider = HybridSearchServiceProvider._();

final class HybridSearchServiceProvider
    extends
        $FunctionalProvider<
          HybridSearchService?,
          HybridSearchService?,
          HybridSearchService?
        >
    with $Provider<HybridSearchService?> {
  HybridSearchServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hybridSearchServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hybridSearchServiceHash();

  @$internal
  @override
  $ProviderElement<HybridSearchService?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HybridSearchService? create(Ref ref) {
    return hybridSearchService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HybridSearchService? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HybridSearchService?>(value),
    );
  }
}

String _$hybridSearchServiceHash() =>
    r'e25becf716081b78f75c919698315a449d404950';

@ProviderFor(summaryService)
final summaryServiceProvider = SummaryServiceProvider._();

final class SummaryServiceProvider
    extends
        $FunctionalProvider<
          AsyncValue<SummaryHierarchyService?>,
          SummaryHierarchyService?,
          FutureOr<SummaryHierarchyService?>
        >
    with
        $FutureModifier<SummaryHierarchyService?>,
        $FutureProvider<SummaryHierarchyService?> {
  SummaryServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'summaryServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$summaryServiceHash();

  @$internal
  @override
  $FutureProviderElement<SummaryHierarchyService?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SummaryHierarchyService?> create(Ref ref) {
    return summaryService(ref);
  }
}

String _$summaryServiceHash() => r'2318ff8db655baccf16ca4643524d67af82d37c8';

/// Per-document embedding indexing progress, for the status bar
/// (docs/05_PROCESSING.md §10 — `indexing... X%`).

@ProviderFor(IndexingProgress)
final indexingProgressProvider = IndexingProgressProvider._();

/// Per-document embedding indexing progress, for the status bar
/// (docs/05_PROCESSING.md §10 — `indexing... X%`).
final class IndexingProgressProvider
    extends $NotifierProvider<IndexingProgress, Map<String, (int, int)>> {
  /// Per-document embedding indexing progress, for the status bar
  /// (docs/05_PROCESSING.md §10 — `indexing... X%`).
  IndexingProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'indexingProgressProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$indexingProgressHash();

  @$internal
  @override
  IndexingProgress create() => IndexingProgress();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, (int, int)> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, (int, int)>>(value),
    );
  }
}

String _$indexingProgressHash() => r'747189b31ec493761f434ee8ab3178f33711159e';

/// Per-document embedding indexing progress, for the status bar
/// (docs/05_PROCESSING.md §10 — `indexing... X%`).

abstract class _$IndexingProgress extends $Notifier<Map<String, (int, int)>> {
  Map<String, (int, int)> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<Map<String, (int, int)>, Map<String, (int, int)>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, (int, int)>, Map<String, (int, int)>>,
              Map<String, (int, int)>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
