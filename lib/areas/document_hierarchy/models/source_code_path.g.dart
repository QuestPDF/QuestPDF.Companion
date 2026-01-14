// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_code_path.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceCodePath _$SourceCodePathFromJson(Map<String, dynamic> json) => SourceCodePath(
      json['filePath'] as String,
      (json['lineNumber'] as num).toInt(),
    );

Map<String, dynamic> _$SourceCodePathToJson(SourceCodePath instance) => <String, dynamic>{
      'filePath': instance.filePath,
      'lineNumber': instance.lineNumber,
    };
