// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_structure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentStructure _$DocumentStructureFromJson(Map<String, dynamic> json) => DocumentStructure(
      json['isDocumentHotReloaded'] as bool,
      (json['pages'] as List<dynamic>)
          .map((e) => DocumentStructurePageSize.fromJson(e as Map<String, dynamic>))
          .toList(),
      DocumentHierarchyElement.fromJson(json['hierarchy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DocumentStructureToJson(DocumentStructure instance) => <String, dynamic>{
      'isDocumentHotReloaded': instance.isDocumentHotReloaded,
      'pages': instance.pages,
      'hierarchy': instance.hierarchy,
    };
