// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SelectionRect {

 double get x; double get y; double get width; double get height;
/// Create a copy of SelectionRect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectionRectCopyWith<SelectionRect> get copyWith => _$SelectionRectCopyWithImpl<SelectionRect>(this as SelectionRect, _$identity);

  /// Serializes this SelectionRect to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectionRect&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y,width,height);

@override
String toString() {
  return 'SelectionRect(x: $x, y: $y, width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class $SelectionRectCopyWith<$Res>  {
  factory $SelectionRectCopyWith(SelectionRect value, $Res Function(SelectionRect) _then) = _$SelectionRectCopyWithImpl;
@useResult
$Res call({
 double x, double y, double width, double height
});




}
/// @nodoc
class _$SelectionRectCopyWithImpl<$Res>
    implements $SelectionRectCopyWith<$Res> {
  _$SelectionRectCopyWithImpl(this._self, this._then);

  final SelectionRect _self;
  final $Res Function(SelectionRect) _then;

/// Create a copy of SelectionRect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = null,Object? y = null,Object? width = null,Object? height = null,}) {
  return _then(_self.copyWith(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SelectionRect].
extension SelectionRectPatterns on SelectionRect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectionRect value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectionRect() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectionRect value)  $default,){
final _that = this;
switch (_that) {
case _SelectionRect():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectionRect value)?  $default,){
final _that = this;
switch (_that) {
case _SelectionRect() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double x,  double y,  double width,  double height)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectionRect() when $default != null:
return $default(_that.x,_that.y,_that.width,_that.height);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double x,  double y,  double width,  double height)  $default,) {final _that = this;
switch (_that) {
case _SelectionRect():
return $default(_that.x,_that.y,_that.width,_that.height);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double x,  double y,  double width,  double height)?  $default,) {final _that = this;
switch (_that) {
case _SelectionRect() when $default != null:
return $default(_that.x,_that.y,_that.width,_that.height);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SelectionRect implements SelectionRect {
  const _SelectionRect({required this.x, required this.y, required this.width, required this.height});
  factory _SelectionRect.fromJson(Map<String, dynamic> json) => _$SelectionRectFromJson(json);

@override final  double x;
@override final  double y;
@override final  double width;
@override final  double height;

/// Create a copy of SelectionRect
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectionRectCopyWith<_SelectionRect> get copyWith => __$SelectionRectCopyWithImpl<_SelectionRect>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectionRectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectionRect&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y,width,height);

@override
String toString() {
  return 'SelectionRect(x: $x, y: $y, width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class _$SelectionRectCopyWith<$Res> implements $SelectionRectCopyWith<$Res> {
  factory _$SelectionRectCopyWith(_SelectionRect value, $Res Function(_SelectionRect) _then) = __$SelectionRectCopyWithImpl;
@override @useResult
$Res call({
 double x, double y, double width, double height
});




}
/// @nodoc
class __$SelectionRectCopyWithImpl<$Res>
    implements _$SelectionRectCopyWith<$Res> {
  __$SelectionRectCopyWithImpl(this._self, this._then);

  final _SelectionRect _self;
  final $Res Function(_SelectionRect) _then;

/// Create a copy of SelectionRect
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,Object? width = null,Object? height = null,}) {
  return _then(_SelectionRect(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$SelectionPosition {

 int get startOffset; int get endOffset; List<SelectionRect> get rects;
/// Create a copy of SelectionPosition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectionPositionCopyWith<SelectionPosition> get copyWith => _$SelectionPositionCopyWithImpl<SelectionPosition>(this as SelectionPosition, _$identity);

  /// Serializes this SelectionPosition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectionPosition&&(identical(other.startOffset, startOffset) || other.startOffset == startOffset)&&(identical(other.endOffset, endOffset) || other.endOffset == endOffset)&&const DeepCollectionEquality().equals(other.rects, rects));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startOffset,endOffset,const DeepCollectionEquality().hash(rects));

@override
String toString() {
  return 'SelectionPosition(startOffset: $startOffset, endOffset: $endOffset, rects: $rects)';
}


}

/// @nodoc
abstract mixin class $SelectionPositionCopyWith<$Res>  {
  factory $SelectionPositionCopyWith(SelectionPosition value, $Res Function(SelectionPosition) _then) = _$SelectionPositionCopyWithImpl;
@useResult
$Res call({
 int startOffset, int endOffset, List<SelectionRect> rects
});




}
/// @nodoc
class _$SelectionPositionCopyWithImpl<$Res>
    implements $SelectionPositionCopyWith<$Res> {
  _$SelectionPositionCopyWithImpl(this._self, this._then);

  final SelectionPosition _self;
  final $Res Function(SelectionPosition) _then;

/// Create a copy of SelectionPosition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startOffset = null,Object? endOffset = null,Object? rects = null,}) {
  return _then(_self.copyWith(
startOffset: null == startOffset ? _self.startOffset : startOffset // ignore: cast_nullable_to_non_nullable
as int,endOffset: null == endOffset ? _self.endOffset : endOffset // ignore: cast_nullable_to_non_nullable
as int,rects: null == rects ? _self.rects : rects // ignore: cast_nullable_to_non_nullable
as List<SelectionRect>,
  ));
}

}


/// Adds pattern-matching-related methods to [SelectionPosition].
extension SelectionPositionPatterns on SelectionPosition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectionPosition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectionPosition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectionPosition value)  $default,){
final _that = this;
switch (_that) {
case _SelectionPosition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectionPosition value)?  $default,){
final _that = this;
switch (_that) {
case _SelectionPosition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int startOffset,  int endOffset,  List<SelectionRect> rects)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectionPosition() when $default != null:
return $default(_that.startOffset,_that.endOffset,_that.rects);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int startOffset,  int endOffset,  List<SelectionRect> rects)  $default,) {final _that = this;
switch (_that) {
case _SelectionPosition():
return $default(_that.startOffset,_that.endOffset,_that.rects);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int startOffset,  int endOffset,  List<SelectionRect> rects)?  $default,) {final _that = this;
switch (_that) {
case _SelectionPosition() when $default != null:
return $default(_that.startOffset,_that.endOffset,_that.rects);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SelectionPosition implements SelectionPosition {
  const _SelectionPosition({required this.startOffset, required this.endOffset, final  List<SelectionRect> rects = const <SelectionRect>[]}): _rects = rects;
  factory _SelectionPosition.fromJson(Map<String, dynamic> json) => _$SelectionPositionFromJson(json);

@override final  int startOffset;
@override final  int endOffset;
 final  List<SelectionRect> _rects;
@override@JsonKey() List<SelectionRect> get rects {
  if (_rects is EqualUnmodifiableListView) return _rects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rects);
}


/// Create a copy of SelectionPosition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectionPositionCopyWith<_SelectionPosition> get copyWith => __$SelectionPositionCopyWithImpl<_SelectionPosition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectionPositionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectionPosition&&(identical(other.startOffset, startOffset) || other.startOffset == startOffset)&&(identical(other.endOffset, endOffset) || other.endOffset == endOffset)&&const DeepCollectionEquality().equals(other._rects, _rects));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startOffset,endOffset,const DeepCollectionEquality().hash(_rects));

@override
String toString() {
  return 'SelectionPosition(startOffset: $startOffset, endOffset: $endOffset, rects: $rects)';
}


}

/// @nodoc
abstract mixin class _$SelectionPositionCopyWith<$Res> implements $SelectionPositionCopyWith<$Res> {
  factory _$SelectionPositionCopyWith(_SelectionPosition value, $Res Function(_SelectionPosition) _then) = __$SelectionPositionCopyWithImpl;
@override @useResult
$Res call({
 int startOffset, int endOffset, List<SelectionRect> rects
});




}
/// @nodoc
class __$SelectionPositionCopyWithImpl<$Res>
    implements _$SelectionPositionCopyWith<$Res> {
  __$SelectionPositionCopyWithImpl(this._self, this._then);

  final _SelectionPosition _self;
  final $Res Function(_SelectionPosition) _then;

/// Create a copy of SelectionPosition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startOffset = null,Object? endOffset = null,Object? rects = null,}) {
  return _then(_SelectionPosition(
startOffset: null == startOffset ? _self.startOffset : startOffset // ignore: cast_nullable_to_non_nullable
as int,endOffset: null == endOffset ? _self.endOffset : endOffset // ignore: cast_nullable_to_non_nullable
as int,rects: null == rects ? _self._rects : rects // ignore: cast_nullable_to_non_nullable
as List<SelectionRect>,
  ));
}


}

/// @nodoc
mixin _$ReaderSelection {

 String get text; int get pageNumber; SelectionPosition get position;
/// Create a copy of ReaderSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReaderSelectionCopyWith<ReaderSelection> get copyWith => _$ReaderSelectionCopyWithImpl<ReaderSelection>(this as ReaderSelection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReaderSelection&&(identical(other.text, text) || other.text == text)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.position, position) || other.position == position));
}


@override
int get hashCode => Object.hash(runtimeType,text,pageNumber,position);

@override
String toString() {
  return 'ReaderSelection(text: $text, pageNumber: $pageNumber, position: $position)';
}


}

/// @nodoc
abstract mixin class $ReaderSelectionCopyWith<$Res>  {
  factory $ReaderSelectionCopyWith(ReaderSelection value, $Res Function(ReaderSelection) _then) = _$ReaderSelectionCopyWithImpl;
@useResult
$Res call({
 String text, int pageNumber, SelectionPosition position
});


$SelectionPositionCopyWith<$Res> get position;

}
/// @nodoc
class _$ReaderSelectionCopyWithImpl<$Res>
    implements $ReaderSelectionCopyWith<$Res> {
  _$ReaderSelectionCopyWithImpl(this._self, this._then);

  final ReaderSelection _self;
  final $Res Function(ReaderSelection) _then;

/// Create a copy of ReaderSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? pageNumber = null,Object? position = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as SelectionPosition,
  ));
}
/// Create a copy of ReaderSelection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectionPositionCopyWith<$Res> get position {
  
  return $SelectionPositionCopyWith<$Res>(_self.position, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReaderSelection].
extension ReaderSelectionPatterns on ReaderSelection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReaderSelection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReaderSelection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReaderSelection value)  $default,){
final _that = this;
switch (_that) {
case _ReaderSelection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReaderSelection value)?  $default,){
final _that = this;
switch (_that) {
case _ReaderSelection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  int pageNumber,  SelectionPosition position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReaderSelection() when $default != null:
return $default(_that.text,_that.pageNumber,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  int pageNumber,  SelectionPosition position)  $default,) {final _that = this;
switch (_that) {
case _ReaderSelection():
return $default(_that.text,_that.pageNumber,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  int pageNumber,  SelectionPosition position)?  $default,) {final _that = this;
switch (_that) {
case _ReaderSelection() when $default != null:
return $default(_that.text,_that.pageNumber,_that.position);case _:
  return null;

}
}

}

/// @nodoc


class _ReaderSelection implements ReaderSelection {
  const _ReaderSelection({required this.text, required this.pageNumber, required this.position});
  

@override final  String text;
@override final  int pageNumber;
@override final  SelectionPosition position;

/// Create a copy of ReaderSelection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReaderSelectionCopyWith<_ReaderSelection> get copyWith => __$ReaderSelectionCopyWithImpl<_ReaderSelection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReaderSelection&&(identical(other.text, text) || other.text == text)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.position, position) || other.position == position));
}


@override
int get hashCode => Object.hash(runtimeType,text,pageNumber,position);

@override
String toString() {
  return 'ReaderSelection(text: $text, pageNumber: $pageNumber, position: $position)';
}


}

/// @nodoc
abstract mixin class _$ReaderSelectionCopyWith<$Res> implements $ReaderSelectionCopyWith<$Res> {
  factory _$ReaderSelectionCopyWith(_ReaderSelection value, $Res Function(_ReaderSelection) _then) = __$ReaderSelectionCopyWithImpl;
@override @useResult
$Res call({
 String text, int pageNumber, SelectionPosition position
});


@override $SelectionPositionCopyWith<$Res> get position;

}
/// @nodoc
class __$ReaderSelectionCopyWithImpl<$Res>
    implements _$ReaderSelectionCopyWith<$Res> {
  __$ReaderSelectionCopyWithImpl(this._self, this._then);

  final _ReaderSelection _self;
  final $Res Function(_ReaderSelection) _then;

/// Create a copy of ReaderSelection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? pageNumber = null,Object? position = null,}) {
  return _then(_ReaderSelection(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as SelectionPosition,
  ));
}

/// Create a copy of ReaderSelection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectionPositionCopyWith<$Res> get position {
  
  return $SelectionPositionCopyWith<$Res>(_self.position, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}

// dart format on
