import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/document_hierarchy_element.dart';

class HierarchyViewItem {
  DocumentHierarchyElement element;
  int nesting;

  HierarchyViewItem(this.element, this.nesting);
}

final documentHierarchyHoveredElementProviderInstance = DocumentHierarchyHoveredElementProvider();
final documentHierarchyHoveredElementProvider =
    ChangeNotifierProvider((ref) => documentHierarchyHoveredElementProviderInstance);

class DocumentHierarchyHoveredElementProvider extends ChangeNotifier {
  DocumentHierarchyElement? hoveredElement;

  void setHoveredElement(DocumentHierarchyElement? newState) {
    hoveredElement = newState;
    notifyListeners();
  }
}
