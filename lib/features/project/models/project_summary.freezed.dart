// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectSummary {

 String get id; String get name; String? get description; String? get area; int get documentCount; int get annotationCount; double get readProgress; int? get lastReadAt;
/// Create a copy of ProjectSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectSummaryCopyWith<ProjectSummary> get copyWith => _$ProjectSummaryCopyWithImpl<ProjectSummary>(this as ProjectSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.area, area) || other.area == area)&&(identical(other.documentCount, documentCount) || other.documentCount == documentCount)&&(identical(other.annotationCount, annotationCount) || other.annotationCount == annotationCount)&&(identical(other.readProgress, readProgress) || other.readProgress == readProgress)&&(identical(other.lastReadAt, lastReadAt) || other.lastReadAt == lastReadAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,area,documentCount,annotationCount,readProgress,lastReadAt);

@override
String toString() {
  return 'ProjectSummary(id: $id, name: $name, description: $description, area: $area, documentCount: $documentCount, annotationCount: $annotationCount, readProgress: $readProgress, lastReadAt: $lastReadAt)';
}


}

/// @nodoc
abstract mixin class $ProjectSummaryCopyWith<$Res>  {
  factory $ProjectSummaryCopyWith(ProjectSummary value, $Res Function(ProjectSummary) _then) = _$ProjectSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, String? area, int documentCount, int annotationCount, double readProgress, int? lastReadAt
});




}
/// @nodoc
class _$ProjectSummaryCopyWithImpl<$Res>
    implements $ProjectSummaryCopyWith<$Res> {
  _$ProjectSummaryCopyWithImpl(this._self, this._then);

  final ProjectSummary _self;
  final $Res Function(ProjectSummary) _then;

/// Create a copy of ProjectSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? area = freezed,Object? documentCount = null,Object? annotationCount = null,Object? readProgress = null,Object? lastReadAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,documentCount: null == documentCount ? _self.documentCount : documentCount // ignore: cast_nullable_to_non_nullable
as int,annotationCount: null == annotationCount ? _self.annotationCount : annotationCount // ignore: cast_nullable_to_non_nullable
as int,readProgress: null == readProgress ? _self.readProgress : readProgress // ignore: cast_nullable_to_non_nullable
as double,lastReadAt: freezed == lastReadAt ? _self.lastReadAt : lastReadAt // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectSummary].
extension ProjectSummaryPatterns on ProjectSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectSummary value)  $default,){
final _that = this;
switch (_that) {
case _ProjectSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String? area,  int documentCount,  int annotationCount,  double readProgress,  int? lastReadAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectSummary() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.area,_that.documentCount,_that.annotationCount,_that.readProgress,_that.lastReadAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String? area,  int documentCount,  int annotationCount,  double readProgress,  int? lastReadAt)  $default,) {final _that = this;
switch (_that) {
case _ProjectSummary():
return $default(_that.id,_that.name,_that.description,_that.area,_that.documentCount,_that.annotationCount,_that.readProgress,_that.lastReadAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  String? area,  int documentCount,  int annotationCount,  double readProgress,  int? lastReadAt)?  $default,) {final _that = this;
switch (_that) {
case _ProjectSummary() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.area,_that.documentCount,_that.annotationCount,_that.readProgress,_that.lastReadAt);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectSummary implements ProjectSummary {
  const _ProjectSummary({required this.id, required this.name, this.description, this.area, required this.documentCount, required this.annotationCount, required this.readProgress, this.lastReadAt});
  

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  String? area;
@override final  int documentCount;
@override final  int annotationCount;
@override final  double readProgress;
@override final  int? lastReadAt;

/// Create a copy of ProjectSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectSummaryCopyWith<_ProjectSummary> get copyWith => __$ProjectSummaryCopyWithImpl<_ProjectSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.area, area) || other.area == area)&&(identical(other.documentCount, documentCount) || other.documentCount == documentCount)&&(identical(other.annotationCount, annotationCount) || other.annotationCount == annotationCount)&&(identical(other.readProgress, readProgress) || other.readProgress == readProgress)&&(identical(other.lastReadAt, lastReadAt) || other.lastReadAt == lastReadAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,area,documentCount,annotationCount,readProgress,lastReadAt);

@override
String toString() {
  return 'ProjectSummary(id: $id, name: $name, description: $description, area: $area, documentCount: $documentCount, annotationCount: $annotationCount, readProgress: $readProgress, lastReadAt: $lastReadAt)';
}


}

/// @nodoc
abstract mixin class _$ProjectSummaryCopyWith<$Res> implements $ProjectSummaryCopyWith<$Res> {
  factory _$ProjectSummaryCopyWith(_ProjectSummary value, $Res Function(_ProjectSummary) _then) = __$ProjectSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, String? area, int documentCount, int annotationCount, double readProgress, int? lastReadAt
});




}
/// @nodoc
class __$ProjectSummaryCopyWithImpl<$Res>
    implements _$ProjectSummaryCopyWith<$Res> {
  __$ProjectSummaryCopyWithImpl(this._self, this._then);

  final _ProjectSummary _self;
  final $Res Function(_ProjectSummary) _then;

/// Create a copy of ProjectSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? area = freezed,Object? documentCount = null,Object? annotationCount = null,Object? readProgress = null,Object? lastReadAt = freezed,}) {
  return _then(_ProjectSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,documentCount: null == documentCount ? _self.documentCount : documentCount // ignore: cast_nullable_to_non_nullable
as int,annotationCount: null == annotationCount ? _self.annotationCount : annotationCount // ignore: cast_nullable_to_non_nullable
as int,readProgress: null == readProgress ? _self.readProgress : readProgress // ignore: cast_nullable_to_non_nullable
as double,lastReadAt: freezed == lastReadAt ? _self.lastReadAt : lastReadAt // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
