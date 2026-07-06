// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotation_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(annotationRepository)
final annotationRepositoryProvider = AnnotationRepositoryProvider._();

final class AnnotationRepositoryProvider
    extends
        $FunctionalProvider<
          AnnotationRepository,
          AnnotationRepository,
          AnnotationRepository
        >
    with $Provider<AnnotationRepository> {
  AnnotationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'annotationRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$annotationRepositoryHash();

  @$internal
  @override
  $ProviderElement<AnnotationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AnnotationRepository create(Ref ref) {
    return annotationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnnotationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnnotationRepository>(value),
    );
  }
}

String _$annotationRepositoryHash() =>
    r'6931ee5f7ce672576791545a24f0ab6a42ba827b';

@ProviderFor(annotationList)
final annotationListProvider = AnnotationListFamily._();

final class AnnotationListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AnnotationRow>>,
          List<AnnotationRow>,
          Stream<List<AnnotationRow>>
        >
    with
        $FutureModifier<List<AnnotationRow>>,
        $StreamProvider<List<AnnotationRow>> {
  AnnotationListProvider._({
    required AnnotationListFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'annotationListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$annotationListHash();

  @override
  String toString() {
    return r'annotationListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<AnnotationRow>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<AnnotationRow>> create(Ref ref) {
    final argument = this.argument as String;
    return annotationList(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AnnotationListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$annotationListHash() => r'4c3199f1316f6fa42ff33122068d781aa0cb7236';

final class AnnotationListFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<AnnotationRow>>, String> {
  AnnotationListFamily._()
    : super(
        retry: null,
        name: r'annotationListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AnnotationListProvider call(String documentId) =>
      AnnotationListProvider._(argument: documentId, from: this);

  @override
  String toString() => r'annotationListProvider';
}

@ProviderFor(AnnotationFilterController)
final annotationFilterControllerProvider =
    AnnotationFilterControllerProvider._();

final class AnnotationFilterControllerProvider
    extends $NotifierProvider<AnnotationFilterController, AnnotationFilter> {
  AnnotationFilterControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'annotationFilterControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$annotationFilterControllerHash();

  @$internal
  @override
  AnnotationFilterController create() => AnnotationFilterController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnnotationFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnnotationFilter>(value),
    );
  }
}

String _$annotationFilterControllerHash() =>
    r'8cdf0b15eddf1f5a20c5bfff5d0c181c0d52265d';

abstract class _$AnnotationFilterController
    extends $Notifier<AnnotationFilter> {
  AnnotationFilter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AnnotationFilter, AnnotationFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AnnotationFilter, AnnotationFilter>,
              AnnotationFilter,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
