import 'dart:math';

import '../../areas/document_hierarchy/models/element_property.dart';

String? getDefaultTreeViewHint(String elementType, List<ElementProperty> properties) {
  getProperty(String label) {
    return properties.where((x) => x.label == label).firstOrNull?.value;
  }

  if (elementType == "TextBlock") {
    final text = getProperty("Text") ?? "";
    return text.substring(0, min(50, text.length));
  }

  return null;
}
