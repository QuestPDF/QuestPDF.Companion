// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_supported_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationSupportedApiResponse _$ApplicationSupportedApiResponseFromJson(Map<String, dynamic> json) =>
    ApplicationSupportedApiResponse(
      (json['supportedVersions'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
    );

Map<String, dynamic> _$ApplicationSupportedApiResponseToJson(ApplicationSupportedApiResponse instance) =>
    <String, dynamic>{
      'supportedVersions': instance.supportedVersions,
    };
