// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_notify_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationNotifyCommand _$ApplicationNotifyCommandFromJson(
        Map<String, dynamic> json) =>
    ApplicationNotifyCommand(
      json['clientId'] as String,
      $enumDecode(_$LicenseTypeEnumMap, json['license']),
    );

Map<String, dynamic> _$ApplicationNotifyCommandToJson(
        ApplicationNotifyCommand instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'license': _$LicenseTypeEnumMap[instance.license]!,
    };

const _$LicenseTypeEnumMap = {
  LicenseType.community: 'community',
  LicenseType.professional: 'professional',
  LicenseType.enterprise: 'enterprise',
};
