import 'package:flutter/widgets.dart';

typedef IsTreeViewModelItemDimmed<TContent> = bool Function(TContent value);

class TreeViewModel<TContent> {
  final String label;
  final Color? annotationColor;

  final String? hint;
  final bool isHintImportant;

  final bool isHighlighted;
  final IsTreeViewModelItemDimmed<TContent> isDimmed;
  final bool isSelected;
  final bool isExpanded;

  TreeViewModel? parent;
  final bool isSingleChildContainer;
  final List<TreeViewModel<TContent>> children;

  bool get isFolder => !isSingleChildContainer && children.isNotEmpty;

  bool get isExpandable => isFolder || (parent?.isFolder ?? false);

  final TContent content;

  final ChangeNotifier? notifier;
  final VoidCallback? onClick;

  TreeViewModel(
      {required this.label,
      this.annotationColor,
      this.hint,
      required this.isHintImportant,
      required this.isHighlighted,
      required this.isDimmed,
      required this.isSelected,
      required this.isExpanded,
      required this.isSingleChildContainer,
      required this.children,
      required this.content,
      required this.notifier,
      this.onClick});

  void updateHierarchy() {
    for (final child in children) {
      child.parent = this;
      child.updateHierarchy();
    }
  }
}
