// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_page_snapshots_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePageSnapshotsCommand _$UpdatePageSnapshotsCommandFromJson(
        Map<String, dynamic> json) =>
    UpdatePageSnapshotsCommand(
      (json['pages'] as List<dynamic>)
          .map((e) => PageSnapshotRendered.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdatePageSnapshotsCommandToJson(
        UpdatePageSnapshotsCommand instance) =>
    <String, dynamic>{
      'pages': instance.pages,
    };
