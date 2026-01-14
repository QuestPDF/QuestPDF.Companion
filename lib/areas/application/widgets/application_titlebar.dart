import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questpdf_companion/areas/application/widgets/application_titlebar_complex_document_warning.dart';
import 'package:questpdf_companion/areas/application/widgets/application_titlebar_features.dart';
import 'package:questpdf_companion/areas/application/widgets/application_titlebar_feedback.dart';
import 'package:questpdf_companion/areas/application/widgets/application_titlebar_layout_error.dart';

import '../../../typography.dart';
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
        return [const Spacer(), const ApplicationTitlebarUpdateAvailable(), const ApplicationTitlebarCloseButton()];
      }

      if (currentMode == ApplicationMode.settings) {
        return [
          const SizedBox(width: 12),
          ...buildApplicationTitle(context),
          const Spacer(),
          const ApplicationTitlebarCloseButton()
        ];
      }

      return [
        if (currentMode == ApplicationMode.documentPreview) const ApplicationTitlebarHierarchyVisibilityToggle(),
        if (currentMode != ApplicationMode.documentPreview) const SizedBox(width: 24),
        const SizedBox(width: 8),
        const ApplicationTitlebarLogo(),
        const Spacer(),
        const ApplicationTitlebarLayoutError(),
        const ApplicationTitlebarHotReloadWarning(),
        const ApplicationTitlebarComplexDocumentWarning(),
        const ApplicationTitlebarLicense(),
        const ApplicationTitlebarUpdateAvailable(),
        const SizedBox(width: 16),
        const ApplicationTitlebarFeatures(),
        const ApplicationTitlebarFeedback(),
        const ApplicationTitlebarCloseButton()
      ];
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: build());
  }

  List<Widget> buildApplicationTitle(BuildContext context) {
    const libraryTitleGradient =
        LinearGradient(colors: [Color(0xFF05D9FF), Color(0xFF2680FF)], transform: GradientRotation(pi / 3));

    final libraryTitleStyle =
        Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.white);

    final applicationTitleStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: FontWeightOptimizedForOperatingSystem.normal);

    final titleText = ShaderMask(
        shaderCallback: (bounds) {
          return libraryTitleGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          );
        },
        child: Text("QuestPDF", style: libraryTitleStyle));

    return [
      titleText,
      const SizedBox(width: 8),
      Text("Companion", style: applicationTitleStyle),
    ];
  }
}
