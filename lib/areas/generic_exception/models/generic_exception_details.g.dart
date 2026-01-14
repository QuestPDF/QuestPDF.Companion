// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_exception_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericExceptionDetails _$GenericExceptionDetailsFromJson(Map<String, dynamic> json) => GenericExceptionDetails(
      json['type'] as String,
      json['message'] as String,
      (json['stackTrace'] as List<dynamic>)
          .map((e) => GenericExceptionStackFrame.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['innerException'] == null
          ? null
          : GenericExceptionDetails.fromJson(json['innerException'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GenericExceptionDetailsToJson(GenericExceptionDetails instance) => <String, dynamic>{
      'type': instance.type,
      'message': instance.message,
      'stackTrace': instance.stackTrace,
      'innerException': instance.innerException,
    };
