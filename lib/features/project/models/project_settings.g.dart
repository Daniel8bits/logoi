// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProjectSettings _$ProjectSettingsFromJson(
  Map<String, dynamic> json,
) => _ProjectSettings(
  defaultProvider: json['defaultProvider'] as String? ?? 'openrouter',
  defaultModel:
      json['defaultModel'] as String? ?? 'anthropic/claude-sonnet-4-6',
  summaryProvider: json['summaryProvider'] as String? ?? 'openrouter',
  summaryModel: json['summaryModel'] as String? ?? 'anthropic/claude-haiku-4-5',
  temperature: (json['temperature'] as num?)?.toDouble() ?? 0.7,
  summaryDepth: (json['summaryDepth'] as num?)?.toInt() ?? 2,
  autoExtractConcepts: json['autoExtractConcepts'] as bool? ?? false,
  autoDetectCrossRefs: json['autoDetectCrossRefs'] as bool? ?? false,
  maxApiRequestsPerHour: (json['maxApiRequestsPerHour'] as num?)?.toInt() ?? 30,
  processOnlyWhenIdle: json['processOnlyWhenIdle'] as bool? ?? false,
);

Map<String, dynamic> _$ProjectSettingsToJson(_ProjectSettings instance) =>
    <String, dynamic>{
      'defaultProvider': instance.defaultProvider,
      'defaultModel': instance.defaultModel,
      'summaryProvider': instance.summaryProvider,
      'summaryModel': instance.summaryModel,
      'temperature': instance.temperature,
      'summaryDepth': instance.summaryDepth,
      'autoExtractConcepts': instance.autoExtractConcepts,
      'autoDetectCrossRefs': instance.autoDetectCrossRefs,
      'maxApiRequestsPerHour': instance.maxApiRequestsPerHour,
      'processOnlyWhenIdle': instance.processOnlyWhenIdle,
    };
