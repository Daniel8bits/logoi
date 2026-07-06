import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_summary.freezed.dart';

/// Aggregated stats shown on a project card (docs/06_UI_UX.md §1.1).
@freezed
abstract class ProjectSummary with _$ProjectSummary {
  const factory ProjectSummary({
    required String id,
    required String name,
    String? description,
    String? area,
    required int documentCount,
    required int annotationCount,
    required double readProgress,
    int? lastReadAt,
  }) = _ProjectSummary;
}
