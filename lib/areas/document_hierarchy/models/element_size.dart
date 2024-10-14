import 'package:json_annotation/json_annotation.dart';

part 'element_size.g.dart';

@JsonSerializable()
class ElementSize {
  final double width;
  final double height;

  ElementSize({required this.width, required this.height});

  factory ElementSize.fromJson(Map<String, dynamic> json) => _$ElementSizeFromJson(json);

  Map<String, dynamic> toJson() => _$ElementSizeToJson(this);
}
