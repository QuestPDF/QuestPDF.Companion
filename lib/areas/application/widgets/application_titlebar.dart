import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questpdf_companion/areas/application/widgets/application_titlebar_complex_document_warning.dart';
import 'package:questpdf_companion/areas/application/widgets/application_titlebar_features.dart';
import 'package:questpdf_companion/areas/application/widgets/application_titlebar_layout_error.dart';

import '../state/application_state_provider.dart';
import 'application_titlebar_close_button.dart';
import 'application_titlebar_hierarchy_visibility_toggle.dart';
import 'application_titlebar_hot_reload_warning.dart';
import 'application_titlebar_license.dart';
import 'application_titlebar_logo.dart';
import 'application_titlebar_update_available.dart';

class ApplicationTitlebar extends ConsumerWidget {
  const ApplicationTitlebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(applicationStateProvider.select((x) => x.currentMode));

    List<Widget> build() {
      if (currentMode == ApplicationMode.welcomeScreen || currentMode == ApplicationMode.communicationError) {
        return [
          const SizedBox(width: 12),
          const ApplicationTitlebarLogo(),
          const Spacer(),
          const ApplicationTitlebarUpdateAvailable(),
          const ApplicationTitlebarCloseButton(),
          const SizedBox(width: 6)
        ];
      }

      if (currentMode == ApplicationMode.settings) {
        return [
          const SizedBox(width: 12),
          const ApplicationTitlebarLogo(),
          const Spacer(),
          const ApplicationTitlebarCloseButton(),
          const SizedBox(width: 6)
        ];
      }

      return [
        const SizedBox(width: 12),
        const ApplicationTitlebarLogo(),
        const Spacer(),
        const ApplicationTitlebarLayoutError(),
        const ApplicationTitlebarHotReloadWarning(),
        const ApplicationTitlebarComplexDocumentWarning(),
        const ApplicationTitlebarLicense(),
        const ApplicationTitlebarUpdateAvailable(),
        const ApplicationTitlebarHierarchyVisibilityToggle(),
        const ApplicationTitlebarFeatures(),
        // const ApplicationTitlebarFeedback(),
        SizedBox(
          height: 24,
          child: VerticalDivider(width: 32),
        ),
        const ApplicationTitlebarCloseButton(),
        const SizedBox(width: 6)
      ];
    }

    return Row(children: build());
  }
}
