import 'package:json_annotation/json_annotation.dart';
import 'package:questpdf_companion/areas/document_hierarchy/models/page_location.dart';

import 'document_hierarchy_element_layout_error_measurement.dart';
import 'element_property.dart';
import 'source_code_path.dart';

part 'document_hierarchy_element.g.dart';

@JsonSerializable()
class DocumentHierarchyElement {
  final String elementType;
  final String? hint;
  final String? searchableContent;
  final bool isSingleChildContainer;
  final List<PageLocation> pageLocations;
  final List<DocumentHierarchyElementLayoutErrorMeasurement> layoutErrorMeasurements;
  final List<ElementProperty> properties;
  final SourceCodePath? sourceCodeDeclarationPath;
  final List<DocumentHierarchyElement> children;

  @JsonKey(includeFromJson: false)
  DocumentHierarchyElement? parent;

  @JsonKey(includeFromJson: false)
  bool isExpanded = false;

  DocumentHierarchyElement(this.elementType, this.hint, this.searchableContent, this.isSingleChildContainer,
      this.pageLocations, this.layoutErrorMeasurements, this.properties, this.sourceCodeDeclarationPath, this.children);

  factory DocumentHierarchyElement.fromJson(Map<String, dynamic> json) => _$DocumentHierarchyElementFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentHierarchyElementToJson(this);
}

extension PageLocationExtensions on DocumentHierarchyElement {
  get isFolder => !isSingleChildContainer && children.isNotEmpty;

  get isExpandable => isFolder || (parent?.isFolder ?? false);

  bool isVisibleOn(List<PageLocation> visibleLocations) {
    for (final visibleLocation in visibleLocations) {
      final elementLocationsOnPage =
          pageLocations.where((element) => element.pageNumber == visibleLocation.pageNumber).toList();

      if (elementLocationsOnPage.any((location) => location.intersects(visibleLocation))) return true;
    }

    return false;
  }

  String getProperty(String label) {
    return properties.where((x) => x.label == label).first.value;
  }
}
