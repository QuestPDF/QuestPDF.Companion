// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_exception_stack_frame.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericExceptionStackFrame _$GenericExceptionStackFrameFromJson(Map<String, dynamic> json) =>
    GenericExceptionStackFrame(
      json['codeLocation'] as String,
      json['fileName'] as String?,
      (json['lineNumber'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GenericExceptionStackFrameToJson(GenericExceptionStackFrame instance) => <String, dynamic>{
      'codeLocation': instance.codeLocation,
      'fileName': instance.fileName,
      'lineNumber': instance.lineNumber,
    };
