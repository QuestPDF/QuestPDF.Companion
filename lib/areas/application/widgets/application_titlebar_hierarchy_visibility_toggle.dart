import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../state/application_state_provider.dart';

class ApplicationTitlebarHierarchyVisibilityToggle extends ConsumerWidget {
  const ApplicationTitlebarHierarchyVisibilityToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHierarchyVisible = ref.watch(applicationStateProvider.select((x) => x.showDocumentHierarchy));
    final icon = isHierarchyVisible ? Symbols.left_panel_close_rounded : Symbols.right_panel_close_rounded;

    return Padding(
      padding: const EdgeInsets.only(left: 1),
      child: IconButton(
          icon: Icon(icon, color: Theme.of(context).colorScheme.onSurfaceVariant),
          tooltip: isHierarchyVisible ? "Hide document hierarchy" : "Show document hierarchy",
          onPressed: applicationStateProviderInstance.toggleDocumentHierarchyVisibility),
    );
  }
}
