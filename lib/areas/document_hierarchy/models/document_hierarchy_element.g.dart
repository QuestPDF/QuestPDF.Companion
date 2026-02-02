// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_hierarchy_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentHierarchyElement _$DocumentHierarchyElementFromJson(Map<String, dynamic> json) => DocumentHierarchyElement(
      json['elementType'] as String,
      json['hint'] as String?,
      json['searchableContent'] as String?,
      json['isSingleChildContainer'] as bool,
      (json['pageLocations'] as List<dynamic>).map((e) => PageLocation.fromJson(e as Map<String, dynamic>)).toList(),
      (json['layoutErrorMeasurements'] as List<dynamic>)
          .map((e) => DocumentHierarchyElementLayoutErrorMeasurement.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['properties'] as List<dynamic>).map((e) => ElementProperty.fromJson(e as Map<String, dynamic>)).toList(),
      json['sourceCodeDeclarationPath'] == null
          ? null
          : SourceCodePath.fromJson(json['sourceCodeDeclarationPath'] as Map<String, dynamic>),
      (json['children'] as List<dynamic>)
          .map((e) => DocumentHierarchyElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DocumentHierarchyElementToJson(DocumentHierarchyElement instance) => <String, dynamic>{
      'elementType': instance.elementType,
      'hint': instance.hint,
      'searchableContent': instance.searchableContent,
      'isSingleChildContainer': instance.isSingleChildContainer,
      'pageLocations': instance.pageLocations,
      'layoutErrorMeasurements': instance.layoutErrorMeasurements,
      'properties': instance.properties,
      'sourceCodeDeclarationPath': instance.sourceCodeDeclarationPath,
      'children': instance.children,
    };
