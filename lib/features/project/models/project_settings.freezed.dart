// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProjectSettings {

 String get defaultProvider; String get defaultModel; String get summaryProvider; String get summaryModel; double get temperature; int get summaryDepth; bool get autoExtractConcepts; bool get autoDetectCrossRefs; int get maxApiRequestsPerHour; bool get processOnlyWhenIdle;
/// Create a copy of ProjectSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectSettingsCopyWith<ProjectSettings> get copyWith => _$ProjectSettingsCopyWithImpl<ProjectSettings>(this as ProjectSettings, _$identity);

  /// Serializes this ProjectSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectSettings&&(identical(other.defaultProvider, defaultProvider) || other.defaultProvider == defaultProvider)&&(identical(other.defaultModel, defaultModel) || other.defaultModel == defaultModel)&&(identical(other.summaryProvider, summaryProvider) || other.summaryProvider == summaryProvider)&&(identical(other.summaryModel, summaryModel) || other.summaryModel == summaryModel)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.summaryDepth, summaryDepth) || other.summaryDepth == summaryDepth)&&(identical(other.autoExtractConcepts, autoExtractConcepts) || other.autoExtractConcepts == autoExtractConcepts)&&(identical(other.autoDetectCrossRefs, autoDetectCrossRefs) || other.autoDetectCrossRefs == autoDetectCrossRefs)&&(identical(other.maxApiRequestsPerHour, maxApiRequestsPerHour) || other.maxApiRequestsPerHour == maxApiRequestsPerHour)&&(identical(other.processOnlyWhenIdle, processOnlyWhenIdle) || other.processOnlyWhenIdle == processOnlyWhenIdle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,defaultProvider,defaultModel,summaryProvider,summaryModel,temperature,summaryDepth,autoExtractConcepts,autoDetectCrossRefs,maxApiRequestsPerHour,processOnlyWhenIdle);

@override
String toString() {
  return 'ProjectSettings(defaultProvider: $defaultProvider, defaultModel: $defaultModel, summaryProvider: $summaryProvider, summaryModel: $summaryModel, temperature: $temperature, summaryDepth: $summaryDepth, autoExtractConcepts: $autoExtractConcepts, autoDetectCrossRefs: $autoDetectCrossRefs, maxApiRequestsPerHour: $maxApiRequestsPerHour, processOnlyWhenIdle: $processOnlyWhenIdle)';
}


}

/// @nodoc
abstract mixin class $ProjectSettingsCopyWith<$Res>  {
  factory $ProjectSettingsCopyWith(ProjectSettings value, $Res Function(ProjectSettings) _then) = _$ProjectSettingsCopyWithImpl;
@useResult
$Res call({
 String defaultProvider, String defaultModel, String summaryProvider, String summaryModel, double temperature, int summaryDepth, bool autoExtractConcepts, bool autoDetectCrossRefs, int maxApiRequestsPerHour, bool processOnlyWhenIdle
});




}
/// @nodoc
class _$ProjectSettingsCopyWithImpl<$Res>
    implements $ProjectSettingsCopyWith<$Res> {
  _$ProjectSettingsCopyWithImpl(this._self, this._then);

  final ProjectSettings _self;
  final $Res Function(ProjectSettings) _then;

/// Create a copy of ProjectSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? defaultProvider = null,Object? defaultModel = null,Object? summaryProvider = null,Object? summaryModel = null,Object? temperature = null,Object? summaryDepth = null,Object? autoExtractConcepts = null,Object? autoDetectCrossRefs = null,Object? maxApiRequestsPerHour = null,Object? processOnlyWhenIdle = null,}) {
  return _then(_self.copyWith(
defaultProvider: null == defaultProvider ? _self.defaultProvider : defaultProvider // ignore: cast_nullable_to_non_nullable
as String,defaultModel: null == defaultModel ? _self.defaultModel : defaultModel // ignore: cast_nullable_to_non_nullable
as String,summaryProvider: null == summaryProvider ? _self.summaryProvider : summaryProvider // ignore: cast_nullable_to_non_nullable
as String,summaryModel: null == summaryModel ? _self.summaryModel : summaryModel // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,summaryDepth: null == summaryDepth ? _self.summaryDepth : summaryDepth // ignore: cast_nullable_to_non_nullable
as int,autoExtractConcepts: null == autoExtractConcepts ? _self.autoExtractConcepts : autoExtractConcepts // ignore: cast_nullable_to_non_nullable
as bool,autoDetectCrossRefs: null == autoDetectCrossRefs ? _self.autoDetectCrossRefs : autoDetectCrossRefs // ignore: cast_nullable_to_non_nullable
as bool,maxApiRequestsPerHour: null == maxApiRequestsPerHour ? _self.maxApiRequestsPerHour : maxApiRequestsPerHour // ignore: cast_nullable_to_non_nullable
as int,processOnlyWhenIdle: null == processOnlyWhenIdle ? _self.processOnlyWhenIdle : processOnlyWhenIdle // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectSettings].
extension ProjectSettingsPatterns on ProjectSettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectSettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectSettings value)  $default,){
final _that = this;
switch (_that) {
case _ProjectSettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectSettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String defaultProvider,  String defaultModel,  String summaryProvider,  String summaryModel,  double temperature,  int summaryDepth,  bool autoExtractConcepts,  bool autoDetectCrossRefs,  int maxApiRequestsPerHour,  bool processOnlyWhenIdle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectSettings() when $default != null:
return $default(_that.defaultProvider,_that.defaultModel,_that.summaryProvider,_that.summaryModel,_that.temperature,_that.summaryDepth,_that.autoExtractConcepts,_that.autoDetectCrossRefs,_that.maxApiRequestsPerHour,_that.processOnlyWhenIdle);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String defaultProvider,  String defaultModel,  String summaryProvider,  String summaryModel,  double temperature,  int summaryDepth,  bool autoExtractConcepts,  bool autoDetectCrossRefs,  int maxApiRequestsPerHour,  bool processOnlyWhenIdle)  $default,) {final _that = this;
switch (_that) {
case _ProjectSettings():
return $default(_that.defaultProvider,_that.defaultModel,_that.summaryProvider,_that.summaryModel,_that.temperature,_that.summaryDepth,_that.autoExtractConcepts,_that.autoDetectCrossRefs,_that.maxApiRequestsPerHour,_that.processOnlyWhenIdle);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String defaultProvider,  String defaultModel,  String summaryProvider,  String summaryModel,  double temperature,  int summaryDepth,  bool autoExtractConcepts,  bool autoDetectCrossRefs,  int maxApiRequestsPerHour,  bool processOnlyWhenIdle)?  $default,) {final _that = this;
switch (_that) {
case _ProjectSettings() when $default != null:
return $default(_that.defaultProvider,_that.defaultModel,_that.summaryProvider,_that.summaryModel,_that.temperature,_that.summaryDepth,_that.autoExtractConcepts,_that.autoDetectCrossRefs,_that.maxApiRequestsPerHour,_that.processOnlyWhenIdle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectSettings implements ProjectSettings {
  const _ProjectSettings({this.defaultProvider = 'openrouter', this.defaultModel = 'anthropic/claude-sonnet-4-6', this.summaryProvider = 'openrouter', this.summaryModel = 'anthropic/claude-haiku-4-5', this.temperature = 0.7, this.summaryDepth = 2, this.autoExtractConcepts = false, this.autoDetectCrossRefs = false, this.maxApiRequestsPerHour = 30, this.processOnlyWhenIdle = false});
  factory _ProjectSettings.fromJson(Map<String, dynamic> json) => _$ProjectSettingsFromJson(json);

@override@JsonKey() final  String defaultProvider;
@override@JsonKey() final  String defaultModel;
@override@JsonKey() final  String summaryProvider;
@override@JsonKey() final  String summaryModel;
@override@JsonKey() final  double temperature;
@override@JsonKey() final  int summaryDepth;
@override@JsonKey() final  bool autoExtractConcepts;
@override@JsonKey() final  bool autoDetectCrossRefs;
@override@JsonKey() final  int maxApiRequestsPerHour;
@override@JsonKey() final  bool processOnlyWhenIdle;

/// Create a copy of ProjectSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectSettingsCopyWith<_ProjectSettings> get copyWith => __$ProjectSettingsCopyWithImpl<_ProjectSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectSettings&&(identical(other.defaultProvider, defaultProvider) || other.defaultProvider == defaultProvider)&&(identical(other.defaultModel, defaultModel) || other.defaultModel == defaultModel)&&(identical(other.summaryProvider, summaryProvider) || other.summaryProvider == summaryProvider)&&(identical(other.summaryModel, summaryModel) || other.summaryModel == summaryModel)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.summaryDepth, summaryDepth) || other.summaryDepth == summaryDepth)&&(identical(other.autoExtractConcepts, autoExtractConcepts) || other.autoExtractConcepts == autoExtractConcepts)&&(identical(other.autoDetectCrossRefs, autoDetectCrossRefs) || other.autoDetectCrossRefs == autoDetectCrossRefs)&&(identical(other.maxApiRequestsPerHour, maxApiRequestsPerHour) || other.maxApiRequestsPerHour == maxApiRequestsPerHour)&&(identical(other.processOnlyWhenIdle, processOnlyWhenIdle) || other.processOnlyWhenIdle == processOnlyWhenIdle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,defaultProvider,defaultModel,summaryProvider,summaryModel,temperature,summaryDepth,autoExtractConcepts,autoDetectCrossRefs,maxApiRequestsPerHour,processOnlyWhenIdle);

@override
String toString() {
  return 'ProjectSettings(defaultProvider: $defaultProvider, defaultModel: $defaultModel, summaryProvider: $summaryProvider, summaryModel: $summaryModel, temperature: $temperature, summaryDepth: $summaryDepth, autoExtractConcepts: $autoExtractConcepts, autoDetectCrossRefs: $autoDetectCrossRefs, maxApiRequestsPerHour: $maxApiRequestsPerHour, processOnlyWhenIdle: $processOnlyWhenIdle)';
}


}

/// @nodoc
abstract mixin class _$ProjectSettingsCopyWith<$Res> implements $ProjectSettingsCopyWith<$Res> {
  factory _$ProjectSettingsCopyWith(_ProjectSettings value, $Res Function(_ProjectSettings) _then) = __$ProjectSettingsCopyWithImpl;
@override @useResult
$Res call({
 String defaultProvider, String defaultModel, String summaryProvider, String summaryModel, double temperature, int summaryDepth, bool autoExtractConcepts, bool autoDetectCrossRefs, int maxApiRequestsPerHour, bool processOnlyWhenIdle
});




}
/// @nodoc
class __$ProjectSettingsCopyWithImpl<$Res>
    implements _$ProjectSettingsCopyWith<$Res> {
  __$ProjectSettingsCopyWithImpl(this._self, this._then);

  final _ProjectSettings _self;
  final $Res Function(_ProjectSettings) _then;

/// Create a copy of ProjectSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? defaultProvider = null,Object? defaultModel = null,Object? summaryProvider = null,Object? summaryModel = null,Object? temperature = null,Object? summaryDepth = null,Object? autoExtractConcepts = null,Object? autoDetectCrossRefs = null,Object? maxApiRequestsPerHour = null,Object? processOnlyWhenIdle = null,}) {
  return _then(_ProjectSettings(
defaultProvider: null == defaultProvider ? _self.defaultProvider : defaultProvider // ignore: cast_nullable_to_non_nullable
as String,defaultModel: null == defaultModel ? _self.defaultModel : defaultModel // ignore: cast_nullable_to_non_nullable
as String,summaryProvider: null == summaryProvider ? _self.summaryProvider : summaryProvider // ignore: cast_nullable_to_non_nullable
as String,summaryModel: null == summaryModel ? _self.summaryModel : summaryModel // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,summaryDepth: null == summaryDepth ? _self.summaryDepth : summaryDepth // ignore: cast_nullable_to_non_nullable
as int,autoExtractConcepts: null == autoExtractConcepts ? _self.autoExtractConcepts : autoExtractConcepts // ignore: cast_nullable_to_non_nullable
as bool,autoDetectCrossRefs: null == autoDetectCrossRefs ? _self.autoDetectCrossRefs : autoDetectCrossRefs // ignore: cast_nullable_to_non_nullable
as bool,maxApiRequestsPerHour: null == maxApiRequestsPerHour ? _self.maxApiRequestsPerHour : maxApiRequestsPerHour // ignore: cast_nullable_to_non_nullable
as int,processOnlyWhenIdle: null == processOnlyWhenIdle ? _self.processOnlyWhenIdle : processOnlyWhenIdle // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
