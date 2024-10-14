import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../document_hierarchy/models/page_location.dart';

final documentPreviewVisibleContentStateInstance = DocumentPreviewVisibleContentState();
final documentPreviewVisibleContentStateProvider =
    ChangeNotifierProvider((ref) => documentPreviewVisibleContentStateInstance);

class DocumentPreviewVisibleContentState extends ChangeNotifier {
  List<PageLocation> visiblePageLocations = [];

  void update(List<PageLocation> locations) {
    visiblePageLocations = locations;
    notifyListeners();
  }
}
