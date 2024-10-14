import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:questpdf_companion/areas/application/state/application_state_provider.dart';

import '../areas/document_hierarchy/state/document_hierarchy_provider.dart';
import '../areas/document_hierarchy/state/document_hierarchy_search_state.dart';
import '../areas/document_hierarchy/state/document_layout_error_provider.dart';

class KeyboardShortcuts extends StatefulWidget {
  const KeyboardShortcuts({super.key});

  @override
  State<KeyboardShortcuts> createState() => KeyboardShortcutsState();
}

class KeyboardShortcutsState extends State<KeyboardShortcuts> {
  @override
  void initState() {
    HardwareKeyboard.instance.addHandler(handleKeyInteraction);
    super.initState();
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(handleKeyInteraction);
    super.dispose();
  }

  bool handleKeyInteraction(KeyEvent event) {
    if (event is! KeyDownEvent) return false;

    final isControlPressed =
        HardwareKeyboard.instance.isControlPressed || (Platform.isMacOS && HardwareKeyboard.instance.isMetaPressed);

    bool handleGlobalShortcuts() {
      if (kDebugMode && isControlPressed && event.physicalKey == PhysicalKeyboardKey.keyD) {
        applicationStateProviderInstance.changeThemeMode(ThemeMode.dark);
        return true;
      }

      if (kDebugMode && isControlPressed && event.physicalKey == PhysicalKeyboardKey.keyL) {
        applicationStateProviderInstance.changeThemeMode(ThemeMode.light);
        return true;
      }

      return false;
    }

    bool handlePreviewShortcuts() {
      final isPreviewMode = applicationStateProviderInstance.currentMode == ApplicationMode.documentPreview;

      if (!isPreviewMode) return false;

      final isSearchActive = documentHierarchySearchStateInstance.searchPhrase != null;
      final isElementSelected = documentHierarchyProviderInstance.selectedElement != null;
      final documentHasLayoutErrors = documentLayoutErrorProviderInstance.containsLayoutError;

      if (!isSearchActive && isControlPressed && event.physicalKey == PhysicalKeyboardKey.keyF) {
        documentHierarchySearchStateInstance.update(null);
        Future(() => documentHierarchySearchStateInstance.update(""));
        return true;
      }

      if (isSearchActive) {
        if (event.logicalKey == LogicalKeyboardKey.escape) {
          documentHierarchySearchStateInstance.update(null);
          return true;
        }

        if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          documentHierarchySearchStateInstance.changeCurrentSearchIndex(1);
          return true;
        }

        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          documentHierarchySearchStateInstance.changeCurrentSearchIndex(-1);
          return true;
        }

        return false;
      }

      if (isControlPressed && event.physicalKey == PhysicalKeyboardKey.keyW) {
        applicationStateProviderInstance.toggleDocumentHierarchyVisibility();
        return true;
      }

      if (documentHasLayoutErrors) {
        if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          documentLayoutErrorProviderInstance.changeSelectedErrorLayoutPage(1);
          return true;
        }

        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          documentLayoutErrorProviderInstance.changeSelectedErrorLayoutPage(-1);
          return true;
        }
      }

      if (isElementSelected) {
        if (event.logicalKey == LogicalKeyboardKey.escape) {
          documentHierarchyProviderInstance.setSelectedElement(null);
          return true;
        }

        if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          documentHierarchyProviderInstance.changeSelectedElementPageNumberVisibility(1);
          return true;
        }

        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          documentHierarchyProviderInstance.changeSelectedElementPageNumberVisibility(-1);
          return true;
        }
      }

      return false;
    }

    return handleGlobalShortcuts() || handlePreviewShortcuts();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
