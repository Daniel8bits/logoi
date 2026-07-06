// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SelectionRect _$SelectionRectFromJson(Map<String, dynamic> json) =>
    _SelectionRect(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );

Map<String, dynamic> _$SelectionRectToJson(_SelectionRect instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
    };

_SelectionPosition _$SelectionPositionFromJson(Map<String, dynamic> json) =>
    _SelectionPosition(
      startOffset: (json['startOffset'] as num).toInt(),
      endOffset: (json['endOffset'] as num).toInt(),
      rects:
          (json['rects'] as List<dynamic>?)
              ?.map((e) => SelectionRect.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SelectionRect>[],
    );

Map<String, dynamic> _$SelectionPositionToJson(_SelectionPosition instance) =>
    <String, dynamic>{
      'startOffset': instance.startOffset,
      'endOffset': instance.endOffset,
      'rects': instance.rects,
    };
