import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questpdf_companion/areas/application/widgets/application_communication_error.dart';
import 'package:window_manager/window_manager.dart';

import '../../../shared/keyboard_shortcuts.dart';
import '../../document_preview_with_hierarchy_view.dart';
import '../../generic_exception/widgets/generic_exception_view_layout.dart';
import '../../welcome/welcome_view_layout.dart';
import '../state/application_state_provider.dart';
import 'application_titlebar.dart';

class ApplicationLayout extends ConsumerWidget {
  const ApplicationLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const toolbarHeight = 44.0;

    final currentMode = ref.watch(applicationStateProvider.select((x) => x.currentMode));

    Widget getCurrentView() {
      if (currentMode == ApplicationMode.documentPreview) return const DocumentPreviewWithHierarchyView();

      if (currentMode == ApplicationMode.genericException) return const GenericExceptionViewLayout();

      if (currentMode == ApplicationMode.communicationError) return const ApplicationCommunicationError();

      return const WelcomeViewLayout();
    }

    final appBar = AppBar(
        title: const ApplicationTitlebar(),
        titleSpacing: 0,
        toolbarHeight: toolbarHeight,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: Colors.transparent,
        elevation: 0,
        shape: Border(bottom: BorderSide(color: Theme.of(context).dividerColor.withAlpha(64), width: 1)));

    final windowMoveableArea = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) {
        windowManager.startDragging();
      },
      child: Container(height: toolbarHeight),
    );

    return Stack(
      children: [
        const KeyboardShortcuts(),
        Scaffold(backgroundColor: Theme.of(context).colorScheme.surfaceContainer, appBar: appBar, body: getCurrentView()),
        windowMoveableArea
      ],
    );
  }
}
