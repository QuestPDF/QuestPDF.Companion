import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/font_awesome_icons.dart';
import '../state/application_state_provider.dart';

class ApplicationTitlebarHierarchyVisibilityToggle extends ConsumerWidget {
  const ApplicationTitlebarHierarchyVisibilityToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHierarchyVisible = ref.watch(applicationStateProvider.select((x) => x.showDocumentHierarchy));
    final icon = isHierarchyVisible ? FontAwesomeIcons.sidebarLeft : FontAwesomeIcons.sidebarRight;

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: IconButton(
          icon: Icon(icon, color: Theme.of(context).colorScheme.onSurfaceVariant, size: 20),
          tooltip: isHierarchyVisible ? "Hide document hierarchy" : "Show document hierarchy",
          onPressed: applicationStateProviderInstance.toggleDocumentHierarchyVisibility),
    );
  }
}
