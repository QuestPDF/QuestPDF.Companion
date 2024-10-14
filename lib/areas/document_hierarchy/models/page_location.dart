import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

part 'page_location.g.dart';

@JsonSerializable()
class PageLocation {
  final int pageNumber;
  final double left;
  final double top;
  final double right;
  final double bottom;

  PageLocation(
      {required this.pageNumber, required this.left, required this.top, required this.right, required this.bottom});

  const PageLocation.fromPLTRB(this.pageNumber, this.left, this.top, this.right, this.bottom);

  factory PageLocation.fromJson(Map<String, dynamic> json) => _$PageLocationFromJson(json);

  Map<String, dynamic> toJson() => _$PageLocationToJson(this);
}

extension PageLocationExtensions on PageLocation {
  get width => right - left;

  get height => bottom - top;

  get area => width * height;

  bool intersects(PageLocation other) {
    return pageNumber == other.pageNumber &&
        left <= other.right &&
        right >= other.left &&
        top <= other.bottom &&
        bottom >= other.top;
  }

  Rect toRect() {
    return Rect.fromLTRB(left, top, right, bottom);
  }
}
