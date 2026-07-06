import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_settings.freezed.dart';
part 'project_settings.g.dart';

/// Per-project settings serialized to projects.settings
/// (docs/03_DATABASE.md §3.1).
@freezed
abstract class ProjectSettings with _$ProjectSettings {
  const factory ProjectSettings({
    @Default('openrouter') String defaultProvider,
    @Default('anthropic/claude-sonnet-4-6') String defaultModel,
    @Default('openrouter') String summaryProvider,
    @Default('anthropic/claude-haiku-4-5') String summaryModel,
    @Default(0.7) double temperature,
    @Default(2) int summaryDepth,
    @Default(false) bool autoExtractConcepts,
    @Default(false) bool autoDetectCrossRefs,
    @Default(30) int maxApiRequestsPerHour,
    @Default(false) bool processOnlyWhenIdle,
  }) = _ProjectSettings;

  factory ProjectSettings.fromJson(Map<String, dynamic> json) =>
      _$ProjectSettingsFromJson(json);
}
