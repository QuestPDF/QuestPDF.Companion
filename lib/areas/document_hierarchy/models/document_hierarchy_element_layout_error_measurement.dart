import 'package:json_annotation/json_annotation.dart';

import 'element_size.dart';

part 'document_hierarchy_element_layout_error_measurement.g.dart';

enum SpacePlanType { empty, wrap, partialRender, fullRender }

@JsonSerializable()
class DocumentHierarchyElementLayoutErrorMeasurement {
  final int pageNumber;
  final ElementSize? availableSpace;
  final ElementSize? measurementSize;
  final SpacePlanType? spacePlanType;
  final String? wrapReason;
  final bool isLayoutErrorRootCause;

  @JsonKey(includeFromJson: false)
  DocumentHierarchyElementLayoutErrorMeasurement? parent;

  DocumentHierarchyElementLayoutErrorMeasurement(this.pageNumber, this.availableSpace, this.measurementSize,
      this.spacePlanType, this.wrapReason, this.isLayoutErrorRootCause);

  factory DocumentHierarchyElementLayoutErrorMeasurement.fromJson(Map<String, dynamic> json) =>
      _$DocumentHierarchyElementLayoutErrorMeasurementFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentHierarchyElementLayoutErrorMeasurementToJson(this);
}
