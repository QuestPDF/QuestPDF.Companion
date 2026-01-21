import 'package:flutter/material.dart';
import 'package:questpdf_companion/shared/tree_view/tree_view_model.dart';

import '../../typography.dart';

class TreeViewItem<TContent> extends StatefulWidget {
  final int indentationLevel;
  final TreeViewModel<TContent> node;

  const TreeViewItem({super.key, required this.node, required this.indentationLevel});

  @override
  State<TreeViewItem<TContent>> createState() => TreeViewItemState<TContent>();
}

class TreeViewItemState<TContent> extends State<TreeViewItem<TContent>> {
  static const double indentationSize = 24;
  static const double iconSize = 16;
  static const double iconSpacing = indentationSize - iconSize;
  static const double annotationSize = 8;
  static const double annotationSpacing = indentationSize - annotationSize;

  static const IconData folderClosedIcon = IconData(0xf07b, fontFamily: "FontAwesome Light");
  static const IconData folderOpenIcon = IconData(0xf07c, fontFamily: "FontAwesome Light");
  static const IconData folderItemIcon = IconData(0xf105, fontFamily: "FontAwesome Light");

  static TextStyle labelStyle = TextStyle(fontWeight: FontWeightOptimizedForOperatingSystem.normal);
  static TextStyle highlightedLabelStyle = TextStyle(fontWeight: FontWeightOptimizedForOperatingSystem.semibold);
  static TextStyle hintStyle =
      TextStyle(fontWeight: FontWeightOptimizedForOperatingSystem.thin, fontStyle: FontStyle.italic);

  static const highEmphasisOpacity = 255;
  static const lowEmphasisOpacity = 128;

  bool isDimmed = false;
  bool isHovered = false;

  TreeViewModel<TContent> get node => widget.node;

  int get indentationLevel => widget.indentationLevel;

  @override
  void initState() {
    super.initState();
    refreshState();

    node.notifier?.addListener(refreshState);
  }

  @override
  void dispose() {
    node.notifier?.removeListener(refreshState);
    super.dispose();
  }

  void refreshState() {
    Future(() {
      final isDimmedNext = node.isDimmed(node.content);

      if (isDimmed == isDimmedNext) return;

      if (!mounted) return;

      setState(() {
        isDimmed = isDimmedNext;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: buildContentRow());
  }

  Widget buildContentRow() {
    final row = Row(
        children: [if (node.annotationColor != null) buildAnnotation(), ...buildTree(), Expanded(child: buildLabel())]);

    if (!isHovered && !node.isSelected) return row;

    return Stack(
      clipBehavior: Clip.none,
      children: [buildHighlight(), Center(child: row)],
    );
  }

  Widget buildHighlight() {
    const verticalSpacing = 0.0;
    const horizontalSpacing = -6.0;

    return Positioned(
      top: verticalSpacing,
      bottom: verticalSpacing,
      left: horizontalSpacing,
      right: horizontalSpacing,
      child: Container(
          decoration: BoxDecoration(color: getHighlightColor(), borderRadius: const BorderRadius.all(Radius.circular(8)))),
    );
  }

  Color getContentColor() {
    final theme = Theme.of(context);

    final targetColor = node.isHighlighted ? theme.colorScheme.primary : theme.colorScheme.onSurface;
    final targetOpacity = (!isDimmed || isHovered) ? highEmphasisOpacity : lowEmphasisOpacity;
    return targetColor.withAlpha(targetOpacity);
  }

  Color? getHighlightColor() {
    final theme = Theme.of(context);

    if (node.isSelected) return theme.colorScheme.secondaryContainer;

    if (isHovered) return theme.colorScheme.surfaceContainerHighest;

    return null;
  }

  List<Widget> buildTree() {
    final folderIcon = node.isExpanded ? folderOpenIcon : folderClosedIcon;
    final iconColor = getContentColor();

    return [
      SizedBox(width: indentationLevel * indentationSize),
      if (node.parent?.isFolder ?? false) Icon(folderItemIcon, size: 16, color: iconColor),
      if (node.parent?.isFolder ?? false) const SizedBox(width: iconSpacing),
      if (node.isFolder) Icon(folderIcon, size: iconSize, color: iconColor),
      if (node.isFolder) const SizedBox(width: iconSpacing)
    ];
  }

  Widget buildAnnotation() {
    return Container(
        width: annotationSize,
        height: annotationSize,
        margin: const EdgeInsets.only(right: annotationSpacing),
        decoration: BoxDecoration(
            color: node.annotationColor?.withAlpha(isDimmed ? lowEmphasisOpacity : highEmphasisOpacity),
            borderRadius: const BorderRadius.all(Radius.circular(annotationSize))));
  }

  Widget buildLabel() {
    final theme = Theme.of(context);

    final targetLabelStyle = node.isHighlighted ? highlightedLabelStyle : labelStyle;
    final labelColor = getContentColor();

    final hintEmphasis = isHovered || node.isSelected;
    final hintColor = theme.colorScheme.onSurface.withAlpha(hintEmphasis ? highEmphasisOpacity : lowEmphasisOpacity);

    final showHint = node.hint != null && (node.isHintImportant || isHovered || node.isSelected);

    return RichText(
        text: TextSpan(children: [
          TextSpan(text: node.label, style: targetLabelStyle.copyWith(color: labelColor)),
          const WidgetSpan(child: SizedBox(width: 16)),
          if (showHint) TextSpan(text: node.hint, style: hintStyle.copyWith(color: hintColor))
        ]),
        maxLines: 1,
        softWrap: false);
  }
}
