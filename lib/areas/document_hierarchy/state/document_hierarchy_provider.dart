import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/visual_elements.dart';
import '../models/document_hierarchy_element.dart';
import '../models/page_location.dart';
import 'document_layout_error_provider.dart';

class HierarchyViewItem {
  DocumentHierarchyElement element;
  int nesting;

  HierarchyViewItem(this.element, this.nesting);
}

final documentHierarchyProviderInstance = DocumentHierarchyState();
final documentHierarchyProvider = ChangeNotifierProvider((ref) => documentHierarchyProviderInstance);

class DocumentHierarchyState extends ChangeNotifier {
  DocumentHierarchyElement? state;
  DocumentHierarchyElement? selectedElement;
  int? selectedElementPageLocationIndex;

  void setHierarchy(DocumentHierarchyElement newState) {
    updateDocumentStructure(newState);
    _expandClosestChildrenHelper(newState);

    state = newState;
    _expandDocumentContentHelper();
    selectedElement = null;

    notifyListeners();
  }

  void updateDocumentStructure(DocumentHierarchyElement item) {
    for (final element in item.children) {
      element.parent = item;
      updateDocumentStructure(element);
    }
  }

  void _expandDocumentContentHelper() {
    if (state == null) return;

    final documentContent =
        state!.children.firstOrNullWhere((x) => x.properties.where((y) => y.value == "Content").isNotEmpty);

    if (documentContent != null) _expandChildrenSmartHelper(documentContent);
  }

  int _getElementChildrenCount(DocumentHierarchyElement item) {
    return 1 + item.children.map(_getElementChildrenCount).sum();
  }

  void _expandClosestChildrenHelper(DocumentHierarchyElement item) {
    item.isExpanded = true;

    if (item.isFolder) return;

    item.children.forEach(_expandClosestChildrenHelper);
  }

  void _expandAllChildrenHelper(DocumentHierarchyElement item) {
    item.isExpanded = true;
    item.children.forEach(_expandAllChildrenHelper);
  }

  void _collapseAllChildrenHelper(DocumentHierarchyElement item) {
    item.isExpanded = item.isExpandable ? false : true;
    item.children.forEach(_collapseAllChildrenHelper);
  }

  void _expandChildrenSmartHelper(DocumentHierarchyElement item) {
    final childrenCount = _getElementChildrenCount(item);

    if (childrenCount < 32) {
      _expandAllChildrenHelper(item);
    } else {
      _expandClosestChildrenHelper(item);
    }
  }

  void _expandToShowElementHelper(DocumentHierarchyElement? element) {
    while (element != null) {
      element.isExpanded = true;
      element = element.parent;
    }
  }

  void expandVisibleElements(List<PageLocation> visibleLocations) {
    traverse(DocumentHierarchyElement element) {
      element.isExpanded = element.isVisibleOn(visibleLocations);
      element.children.forEach(traverse);
    }

    if (state == null) return;

    traverse(state!);
    notifyListeners();
  }

  void setSelectedElement(DocumentHierarchyElement? newState) {
    if (selectedElement == null && newState == null) return;

    if (selectedElement == newState && selectedElement!.isExpandable && selectedElement!.isExpanded) {
      _collapseAllChildrenHelper(selectedElement!);
      notifyListeners();
      return;
    }

    selectedElement = newState;
    selectedElementPageLocationIndex = 0;

    if (selectedElement != null && selectedElement!.isExpandable) {
      _expandToShowElementHelper(selectedElement!);
      _expandChildrenSmartHelper(selectedElement!);
    }

    notifyListeners();
  }

  void setSelectedElementAndFocusOnIt(DocumentHierarchyElement? newState) {
    if (newState == selectedElement) return;

    setSelectedElement(newState);
    _collapseAllChildrenHelper(selectedElement!);
    _expandToShowElementHelper(selectedElement!);
    _expandChildrenSmartHelper(selectedElement!);
    notifyListeners();
  }

  void changeSelectedElementPageNumberVisibility(int direction) {
    if (selectedElement == null) return;

    selectedElementPageLocationIndex =
        (selectedElementPageLocationIndex! + direction) % selectedElement!.pageLocations.length;
    notifyListeners();
  }

  void findPreviewClickedElement(int pageNumber, double x, double y) {
    if (state == null) return;

    // find all clicked elements
    final clickedPosition = PageLocation.fromPLTRB(pageNumber, x, y, x, y);
    final List<DocumentHierarchyElement> candidates = [];

    void traverse(DocumentHierarchyElement node) {
      final isLeaf = node.children.isEmpty;
      final isVisual = visualElementTypes.contains(node.elementType);
      final isClicked = node.pageLocations.any((pageLocation) => pageLocation.intersects(clickedPosition));

      if ((isLeaf || isVisual) && isClicked) {
        candidates.add(node);
      }

      node.children.forEach(traverse);
    }

    traverse(state!);

    // find smallest element
    final el = candidates
        .flatMap((element) => element.pageLocations
            .mapIndexed((index, pageLocation) => (element: element, pageLocation: pageLocation, index: index))
            .where((x) => x.pageLocation.intersects(clickedPosition)))
        .toList();

    final smallestElement = el.minBy((x) => x.pageLocation.area)!;

    selectedElement = smallestElement.element;
    selectedElementPageLocationIndex = smallestElement.index;
    _collapseAllChildrenHelper(state!);
    _expandToShowElementHelper(selectedElement!);
    _expandChildrenSmartHelper(selectedElement!);
    notifyListeners();
  }

  List<LayoutError> listLayoutErrors() {
    if (state == null) return [];

    List<LayoutError> result = [];

    void traverse(DocumentHierarchyElement element) {
      element.layoutErrorMeasurements
          .where((x) => x.isLayoutErrorRootCause)
          .map((x) => LayoutError(element, x))
          .forEach(result.add);

      element.children.forEach(traverse);
    }

    traverse(state!);
    return result.toList();
  }

  SourceCodeLocation? findSourceCodeLocationOf(DocumentHierarchyElement? element) {
    if (element == null) return null;

    while (true) {
      if (element == null) return null;

      final sourceCodePath = element.sourceCodeDeclarationPath;

      if (sourceCodePath != null) {
        return SourceCodeLocation(
            isAccurate: true, filePath: sourceCodePath.filePath, lineNumber: sourceCodePath.lineNumber);
      }

      if (element.elementType == "SourceCodePointer") {
        final fileName = element.getProperty("FilePath");
        final lineNumber = int.tryParse(element.getProperty("LineNumber"));

        if (fileName.isNullOrEmpty) return null;

        return SourceCodeLocation(isAccurate: false, filePath: fileName, lineNumber: lineNumber!);
      }

      element = element.parent;
    }
  }

  DocumentHierarchyElement? findClickableLink(int pageNumber, double x, double y) {
    if (state == null) return null;

    final clickedPosition = PageLocation.fromPLTRB(pageNumber, x, y, x, y);
    DocumentHierarchyElement? result;

    void traverse(DocumentHierarchyElement node) {
      final isLink = node.elementType == "SectionLink" || node.elementType == "Hyperlink";
      final isClicked = node.pageLocations.any((pageLocation) => pageLocation.intersects(clickedPosition));

      if (isLink && isClicked) {
        result = node;
        return;
      }

      node.children.forEach(traverse);
    }

    traverse(state!);
    return result;
  }

  void openClickableLink(DocumentHierarchyElement element) {
    void openHyperlink(DocumentHierarchyElement element) {
      var url = element.getProperty("Url");

      if (url.isNullOrEmpty) return;

      if (!url.startsWith("http")) {
        url = "https://$url";
      }

      launchUrl(Uri.parse(url));
    }

    DocumentHierarchyElement? findSectionOfName(String targetSectionName) {
      DocumentHierarchyElement? result;

      void traverse(DocumentHierarchyElement node) {
        if (node.elementType == "Section") {
          final sectionName = node.getProperty("SectionName");

          if (sectionName == targetSectionName) {
            result = node;
            return;
          }
        }

        node.children.forEach(traverse);
      }

      traverse(state!);
      return result;
    }

    void openSectionLink(DocumentHierarchyElement element) {
      final sectionName = element.getProperty("SectionName");
      final targetSection = findSectionOfName(sectionName);

      if (targetSection == null) return;

      setSelectedElementAndFocusOnIt(targetSection);
    }

    if (element.elementType == "Hyperlink") {
      openHyperlink(element);
    } else if (element.elementType == "SectionLink") {
      openSectionLink(element);
    }
  }
}

class SourceCodeLocation {
  final bool isAccurate;
  final String filePath;
  final int lineNumber;

  SourceCodeLocation({required this.isAccurate, required this.filePath, required this.lineNumber});
}
