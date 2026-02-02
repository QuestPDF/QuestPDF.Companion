import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questpdf_companion/areas/document_hierarchy/state/document_layout_error_provider.dart';

import '../../../shared/font_awesome_icons.dart';

class DocumentHierarchyLayoutErrorNotification extends ConsumerWidget {
  const DocumentHierarchyLayoutErrorNotification({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layoutErrorProvider = ref.watch(documentLayoutErrorProvider);

    final textColor = Theme.of(context).colorScheme.onErrorContainer;

    final titleTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor);

    return Container(
      color: Theme.of(context).colorScheme.errorContainer,
      padding: const EdgeInsets.only(left: 12, top: 4, right: 4, bottom: 4),
      child: Row(children: [
        Text(
            "Layout error ${layoutErrorProvider.currentlySelectedLayoutErrorIndex + 1} / ${layoutErrorProvider.numberOfLayoutErrors}",
            style: titleTextStyle),
        const Spacer(),
        IconButton(
            icon: Icon(FontAwesomeIcons.arrowUp, color: textColor, size: 16),
            visualDensity: VisualDensity.compact,
            onPressed: () => layoutErrorProvider.changeSelectedErrorLayoutPage(-1)),
        IconButton(
            icon: Icon(FontAwesomeIcons.arrowDown, color: textColor, size: 16),
            visualDensity: VisualDensity.compact,
            onPressed: () => layoutErrorProvider.changeSelectedErrorLayoutPage(1))
      ]),
    );
  }
}
