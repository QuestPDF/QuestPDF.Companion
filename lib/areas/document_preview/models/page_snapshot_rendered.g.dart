// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_snapshot_rendered.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageSnapshotRendered _$PageSnapshotRenderedFromJson(Map<String, dynamic> json) => PageSnapshotRendered(
      (json['pageIndex'] as num).toInt(),
      (json['zoomLevel'] as num).toInt(),
      PageSnapshotRendered._fromBase64(json['imageData'] as String),
    );

Map<String, dynamic> _$PageSnapshotRenderedToJson(PageSnapshotRendered instance) => <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'zoomLevel': instance.zoomLevel,
      'imageData': PageSnapshotRendered._toBase64(instance.imageData),
    };
