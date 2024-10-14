// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageLocation _$PageLocationFromJson(Map<String, dynamic> json) => PageLocation(
      pageNumber: (json['pageNumber'] as num).toInt(),
      left: (json['left'] as num).toDouble(),
      top: (json['top'] as num).toDouble(),
      right: (json['right'] as num).toDouble(),
      bottom: (json['bottom'] as num).toDouble(),
    );

Map<String, dynamic> _$PageLocationToJson(PageLocation instance) =>
    <String, dynamic>{
      'pageNumber': instance.pageNumber,
      'left': instance.left,
      'top': instance.top,
      'right': instance.right,
      'bottom': instance.bottom,
    };
