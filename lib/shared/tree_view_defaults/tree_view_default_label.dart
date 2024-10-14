import '../../areas/document_hierarchy/models/element_property.dart';
import '../prettify_name.dart';

String? getDefaultTreeViewLabel(String elementType, List<ElementProperty> properties) {
  String? getProperty(String label) {
    return properties.where((x) => x.label == label).firstOrNull?.value;
  }

  if (elementType == "SourceCodePointer") return getProperty("MethodName");

  if (elementType == "DebugPointer") {
    return getProperty("Label");
  }

  return prettifyName(elementType);
}
