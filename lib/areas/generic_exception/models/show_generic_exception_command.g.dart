// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_generic_exception_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowGenericExceptionCommand _$ShowGenericExceptionCommandFromJson(Map<String, dynamic> json) =>
    ShowGenericExceptionCommand(
      GenericExceptionDetails.fromJson(json['exception'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShowGenericExceptionCommandToJson(ShowGenericExceptionCommand instance) => <String, dynamic>{
      'exception': instance.exception,
    };
