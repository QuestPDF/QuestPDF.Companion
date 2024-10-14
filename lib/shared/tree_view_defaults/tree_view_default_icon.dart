import 'package:flutter/cupertino.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../areas/document_hierarchy/models/element_property.dart';

IconData? getDefaultTreeViewElementIcon(String elementType, List<ElementProperty> properties) {
  if (elementType == "TextBlock") return Symbols.text_fields_rounded;

  if (elementType == "Image" || elementType == "DynamicImage") return Symbols.image_rounded;

  if (elementType == "Canvas") return Symbols.brush_rounded;

  if (elementType == "LayoutOverflowVisualization") return Symbols.bug_report_rounded;

  if (elementType == "DynamicHost") return Symbols.factory_rounded;

  if (elementType == "PageBreak") return Symbols.cut_rounded;

  if (elementType == "Empty") return Symbols.block;

  if (elementType == "Section") return Symbols.bookmark_rounded;

  if (elementType == "SourceCodePointer") return Symbols.code_rounded;

  if (elementType == "DebugPointer") {
    final type = properties.where((x) => x.label == "Type").first.value;

    if (type == "DocumentStructure") return null;

    if (type == "Component") return Symbols.grid_view_rounded;

    if (type == "Section") return Symbols.bookmark_rounded;

    if (type == "Dynamic") return Symbols.factory_rounded;

    if (type == "UserDefined") return Symbols.start_rounded;

    return null;
  }

  return null;
}
