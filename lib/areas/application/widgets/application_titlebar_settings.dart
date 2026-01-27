import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questpdf_companion/areas/application/state/application_state_provider.dart';
import 'package:questpdf_companion/shared/open_source_code_path_in_editor.dart';

import '../../../shared/font_awesome_icons.dart';
import '../../../typography.dart';

class ApplicationTitlebarSettings extends ConsumerWidget {
  const ApplicationTitlebarSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationState = ref.watch(applicationStateProvider);

    final theme = Theme.of(context);
    final categoryTextStyle = theme.textTheme.titleSmall;
    final labelTextStyle = theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeightOptimizedForOperatingSystem.normal);
    final subtitleTextStyle = theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline);

    Widget buildSectionHeader(String title, {String? subtitle}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: categoryTextStyle),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(subtitle, style: subtitleTextStyle),
            ),
        ],
      );
    }

    Widget buildRadioOption<T>(T value, String label) {
      return RadioListTile<T>(
        value: value,
        title: Text(label, style: labelTextStyle),
        dense: true,
        visualDensity: const VisualDensity(vertical: -4),
        contentPadding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      );
    }

    Widget buildThemeModeSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionHeader("Theme mode", subtitle: "Controls the application's visual appearance"),
          const SizedBox(height: 8),
          RadioGroup<ThemeMode>(
            groupValue: applicationState.themeMode,
            onChanged: (value) => applicationState.changeThemeMode(value),
            child: Transform.translate(
              offset: Offset(-6, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRadioOption(ThemeMode.system, 'System'),
                  buildRadioOption(ThemeMode.light, 'Light'),
                  buildRadioOption(ThemeMode.dark, 'Dark'),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget buildDefaultCodeEditorSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionHeader("Default code editor",
              subtitle: "Opens source code in the selected editor when navigating from the document preview"),
          const SizedBox(height: 8),
          RadioGroup<CodeEditor>(
            groupValue: applicationState.defaultCodeEditor,
            onChanged: (value) => applicationState.changeDefaultCodeEditor(value),
            child: Transform.translate(
              offset: Offset(-6, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: CodeEditor.values.map((x) => buildRadioOption(x, getEditorName(x))).toList(),
              ),
            ),
          ),
        ],
      );
    }

    Widget buildDocumentHierarchySection() {
      return Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Document hierarchy", style: categoryTextStyle),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text("Show side panel with element tree", style: subtitleTextStyle),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            height: 24,
            child: FittedBox(
              child: Switch(
                value: applicationState.showDocumentHierarchy,
                onChanged: (_) => applicationStateProviderInstance.toggleDocumentHierarchyVisibility(),
              ),
            ),
          ),
        ],
      );
    }

    Widget buildTooltipContent() {
      return Container(
        constraints: const BoxConstraints(maxWidth: 350),
        child: Card(
          color: Theme.of(context).cardColor,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Settings", style: theme.textTheme.titleMedium),
                const SizedBox(height: 20),
                buildThemeModeSection(),
                Divider(color: theme.colorScheme.outlineVariant.withValues(alpha: 1), height: 40),
                buildDefaultCodeEditorSection(),
                Divider(color: theme.colorScheme.outlineVariant.withValues(alpha: 1), height: 40),
                buildDocumentHierarchySection(),
              ],
            ),
          ),
        ),
      );
    }

    Widget buildIndicatorIcon() {
      return Padding(
        padding: const EdgeInsets.only(left: 8),
        child: IconButton(
          icon: Icon(FontAwesomeIcons.gear, color: theme.colorScheme.onSurfaceVariant, size: 20),
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.all(4),
          style: ButtonStyle(
            visualDensity: VisualDensity.compact,
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            iconColor: WidgetStateProperty.all(theme.colorScheme.onSurfaceVariant),
          ),
          onPressed: () => {},
        ),
      );
    }

    return Tooltip(
      richMessage: WidgetSpan(child: IntrinsicWidth(child: buildTooltipContent())),
      padding: EdgeInsets.zero,
      enableTapToDismiss: false,
      decoration: const BoxDecoration(),
      exitDuration: const Duration(milliseconds: 200),
      child: buildIndicatorIcon(),
    );
  }
}
