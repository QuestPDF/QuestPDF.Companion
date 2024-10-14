import '../../areas/document_hierarchy/models/element_property.dart';

bool getDefaultTreeViewHighlighting(String elementType, List<ElementProperty> properties) {
  if (elementType == "DebugPointer") {
    final type = properties.where((x) => x.label == "Type").first.value;

    if (type == "DocumentStructure") return true;

    if (type == "Section") return true;

    if (type == "UserDefined") return true;

    return false;
  }

  return false;
}
