import 'package:freezed_annotation/freezed_annotation.dart';

part 'selection.freezed.dart';
part 'selection.g.dart';

/// A rectangle of selected text in PDF page coordinates.
@freezed
abstract class SelectionRect with _$SelectionRect {
  const factory SelectionRect({
    required double x,
    required double y,
    required double width,
    required double height,
  }) = _SelectionRect;

  factory SelectionRect.fromJson(Map<String, dynamic> json) =>
      _$SelectionRectFromJson(json);
}

/// Position payload persisted in annotations.position
/// (docs/03_DATABASE.md §3.8).
@freezed
abstract class SelectionPosition with _$SelectionPosition {
  const factory SelectionPosition({
    required int startOffset,
    required int endOffset,
    @Default(<SelectionRect>[]) List<SelectionRect> rects,
  }) = _SelectionPosition;

  factory SelectionPosition.fromJson(Map<String, dynamic> json) =>
      _$SelectionPositionFromJson(json);
}

/// An active text selection in the reader.
@freezed
abstract class ReaderSelection with _$ReaderSelection {
  const factory ReaderSelection({
    required String text,
    required int pageNumber,
    required SelectionPosition position,
  }) = _ReaderSelection;
}
