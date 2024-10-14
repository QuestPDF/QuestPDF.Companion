// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_hierarchy_element_layout_error_measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentHierarchyElementLayoutErrorMeasurement
    _$DocumentHierarchyElementLayoutErrorMeasurementFromJson(
            Map<String, dynamic> json) =>
        DocumentHierarchyElementLayoutErrorMeasurement(
          (json['pageNumber'] as num).toInt(),
          json['availableSpace'] == null
              ? null
              : ElementSize.fromJson(
                  json['availableSpace'] as Map<String, dynamic>),
          json['measurementSize'] == null
              ? null
              : ElementSize.fromJson(
                  json['measurementSize'] as Map<String, dynamic>),
          $enumDecodeNullable(_$SpacePlanTypeEnumMap, json['spacePlanType']),
          json['wrapReason'] as String?,
          json['isLayoutErrorRootCause'] as bool,
        );

Map<String, dynamic> _$DocumentHierarchyElementLayoutErrorMeasurementToJson(
        DocumentHierarchyElementLayoutErrorMeasurement instance) =>
    <String, dynamic>{
      'pageNumber': instance.pageNumber,
      'availableSpace': instance.availableSpace,
      'measurementSize': instance.measurementSize,
      'spacePlanType': _$SpacePlanTypeEnumMap[instance.spacePlanType],
      'wrapReason': instance.wrapReason,
      'isLayoutErrorRootCause': instance.isLayoutErrorRootCause,
    };

const _$SpacePlanTypeEnumMap = {
  SpacePlanType.empty: 'empty',
  SpacePlanType.wrap: 'wrap',
  SpacePlanType.partialRender: 'partialRender',
  SpacePlanType.fullRender: 'fullRender',
};
