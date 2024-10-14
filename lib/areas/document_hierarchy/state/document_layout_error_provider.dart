import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questpdf_companion/areas/document_hierarchy/models/document_hierarchy_element.dart';

import '../models/document_hierarchy_element_layout_error_measurement.dart';
import 'document_hierarchy_provider.dart';

final documentLayoutErrorProviderInstance = DocumentLayoutErrorProvider();
final documentLayoutErrorProvider = ChangeNotifierProvider((ref) => documentLayoutErrorProviderInstance);

class LayoutError {
  final DocumentHierarchyElement element;
  final DocumentHierarchyElementLayoutErrorMeasurement measurement;

  LayoutError(this.element, this.measurement);
}

class DocumentLayoutErrorProvider extends ChangeNotifier {
  List<LayoutError> layoutErrors = [];
  int currentlySelectedLayoutErrorIndex = 0;

  bool get containsLayoutError => numberOfLayoutErrors > 0;

  int get numberOfLayoutErrors => layoutErrors.length;

  LayoutError get currentlySelectedLayoutError => layoutErrors[currentlySelectedLayoutErrorIndex];

  void update() {
    layoutErrors = documentHierarchyProviderInstance.listLayoutErrors();
    currentlySelectedLayoutErrorIndex = 0;
    changeSelectedErrorLayoutPage(0);
    notifyListeners();
  }

  void changeSelectedErrorLayoutPage(int direction) {
    if (!containsLayoutError) return;

    currentlySelectedLayoutErrorIndex = (currentlySelectedLayoutErrorIndex + direction) % numberOfLayoutErrors;
    documentHierarchyProviderInstance.setSelectedElementAndFocusOnIt(currentlySelectedLayoutError.element);
    notifyListeners();
  }
}
