import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../document_hierarchy/models/document_structure_page_size.dart';
import '../../document_hierarchy/models/page_snapshot_index.dart';
import '../models/page_snapshot_rendered.dart';

final documentPreviewImageCacheStateInstance = DocumentPreviewImageCacheState();
final documentPreviewImageCacheStateProvider = ChangeNotifierProvider((ref) => documentPreviewImageCacheStateInstance);

class DocumentPreviewImageCacheState extends ChangeNotifier {
  num refreshId = 0;
  List<DocumentStructurePageSize> pages = [];

  bool isImagesCacheInvalidated = false;
  Map<String, ui.Image> images = {};

  List<String> neededImages = [];
  Set<String> requestedImages = {};

  void updateDocumentStructure(List<DocumentStructurePageSize> newPages) {
    refreshId++;

    pages = newPages;

    neededImages.clear();
    isImagesCacheInvalidated = true;

    notifyListeners();
  }

  void updateNeededImages(List<PageSnapshotIndex> indexes) {
    neededImages.clear();
    neededImages.addAll(indexes.map((e) => "${e.pageIndex}_${e.zoomLevel}"));
  }

  List<PageSnapshotIndex> getNeededImages() {
    if (neededImages.isEmpty) return [];

    final imagesToRequest =
        neededImages.where((element) => isImagesCacheInvalidated || !images.keys.contains(element)).toList();
    imagesToRequest.forEach(requestedImages.add);
    neededImages.clear();

    return imagesToRequest.map((e) {
      final parts = e.split("_");
      return PageSnapshotIndex(int.parse(parts[0]), int.parse(parts[1]));
    }).toList();
  }

  void addImages(List<PageSnapshotRendered> imagesToAdd) async {
    if (isImagesCacheInvalidated) {
      final imagesToClear = images.values.toList();
      images.clear();

      Future.microtask(() => imagesToClear.forEach((x) => x.dispose()));
      isImagesCacheInvalidated = false;
    }

    for (final image in imagesToAdd) {
      final codec = await instantiateImageCodec(image.imageData);
      final frame = await codec.getNextFrame();

      final cacheKey = "${image.pageIndex}_${image.zoomLevel}";
      images[cacheKey] = frame.image;
    }

    notifyListeners();
  }

  ui.Image? getImage(PageSnapshotIndex index) {
    final zoomLevelPriority = [
      index.zoomLevel,
      ...List.generate(10, (x) => index.zoomLevel + x),
      ...List.generate(10, (x) => index.zoomLevel - x)
    ];

    return zoomLevelPriority
        .map((x) => PageSnapshotIndex(index.pageIndex, x))
        .map(indexToString)
        .map((x) => images[x])
        .where((x) => x != null)
        .firstOrNull;
  }

  String indexToString(PageSnapshotIndex index) {
    return "${index.pageIndex}_${index.zoomLevel}";
  }
}

class DocumentViewerCacheItem {
  final int pageIndex;
  final int zoomLevel;
  bool isInvalidated = false;

  DocumentViewerCacheItem(this.pageIndex, this.zoomLevel);
}
