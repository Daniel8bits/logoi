import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database.dart';
import '../../project/providers/project_providers.dart';
import '../models/annotation_type.dart';
import '../repositories/annotation_repository.dart';

part 'annotation_providers.g.dart';

@riverpod
AnnotationRepository annotationRepository(Ref ref) {
  final context = ref.watch(currentProjectProvider);
  if (context == null) {
    throw StateError('No project open');
  }
  return AnnotationRepository(dao: context.db.annotationDao);
}

@riverpod
Stream<List<AnnotationRow>> annotationList(Ref ref, String documentId) =>
    ref.watch(annotationRepositoryProvider).watchByDocument(documentId);

/// Filter state for the annotations panel (docs/06_UI_UX.md §2.3).
class AnnotationFilter {
  const AnnotationFilter({this.type, this.tag, this.pageNumber});

  final AnnotationType? type;
  final String? tag;
  final int? pageNumber;

  bool get isEmpty => type == null && tag == null && pageNumber == null;
}

@riverpod
class AnnotationFilterController extends _$AnnotationFilterController {
  @override
  AnnotationFilter build() => const AnnotationFilter();

  void setType(AnnotationType? type) =>
      state = AnnotationFilter(type: type, tag: state.tag, pageNumber: state.pageNumber);

  void setTag(String? tag) =>
      state = AnnotationFilter(type: state.type, tag: tag, pageNumber: state.pageNumber);

  void setPage(int? pageNumber) =>
      state = AnnotationFilter(type: state.type, tag: state.tag, pageNumber: pageNumber);

  void clear() => state = const AnnotationFilter();
}
