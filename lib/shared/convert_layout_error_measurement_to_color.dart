import 'package:flutter/material.dart';
import 'package:questpdf_companion/areas/document_hierarchy/models/document_hierarchy_element_layout_error_measurement.dart';

extension DocumentHierarchyElementExtensions on DocumentHierarchyElementLayoutErrorMeasurement? {
  Color? getAnnotationColor() {
    if (this == null) return null;

    if (this!.isLayoutErrorRootCause) return Colors.red;

    if (this!.spacePlanType == SpacePlanType.wrap) return Colors.orange;

    if (this!.spacePlanType == SpacePlanType.partialRender) return Colors.yellow;

    if (this!.spacePlanType == SpacePlanType.fullRender) return Colors.green;

    if (this!.spacePlanType == SpacePlanType.empty) return Colors.green;

    return null;
  }
}
