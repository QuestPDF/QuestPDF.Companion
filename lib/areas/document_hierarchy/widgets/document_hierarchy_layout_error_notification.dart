import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:questpdf_companion/areas/document_hierarchy/state/document_layout_error_provider.dart';

class DocumentHierarchyLayoutErrorNotification extends ConsumerWidget {
  const DocumentHierarchyLayoutErrorNotification({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layoutErrorProvider = ref.watch(documentLayoutErrorProvider);

    final textColor = Theme.of(context).colorScheme.onErrorContainer;

    final titleTextStyle = Theme.of(context).textTheme.titleSmall?.copyWith(color: textColor);

    return Card(
        color: Theme.of(context).colorScheme.errorContainer,
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: Row(children: [
            Text(
                "Layout error ${layoutErrorProvider.currentlySelectedLayoutErrorIndex + 1} / ${layoutErrorProvider.numberOfLayoutErrors}",
                style: titleTextStyle),
            const Spacer(),
            IconButton(
                icon: Icon(Symbols.arrow_upward_alt_rounded, color: textColor),
                onPressed: () => layoutErrorProvider.changeSelectedErrorLayoutPage(-1),
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(2)),
            IconButton(
                icon: Icon(Symbols.arrow_downward_alt_rounded, color: textColor),
                onPressed: () => layoutErrorProvider.changeSelectedErrorLayoutPage(1),
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(2))
          ]),
        ));
  }
}
