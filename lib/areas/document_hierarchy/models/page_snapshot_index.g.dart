// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_snapshot_index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageSnapshotIndex _$PageSnapshotIndexFromJson(Map<String, dynamic> json) =>
    PageSnapshotIndex(
      (json['pageIndex'] as num).toInt(),
      (json['zoomLevel'] as num).toInt(),
    );

Map<String, dynamic> _$PageSnapshotIndexToJson(PageSnapshotIndex instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'zoomLevel': instance.zoomLevel,
    };
