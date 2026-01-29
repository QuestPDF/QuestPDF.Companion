import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questpdf_companion/areas/application/state/application_state_provider.dart';
import 'package:questpdf_companion/shared/open_source_code_path_in_editor.dart';

import '../../../shared/font_awesome_icons.dart';

class ApplicationTitlebarSettings extends ConsumerWidget {
  const ApplicationTitlebarSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationState = ref.watch(applicationStateProvider);

    final theme = Theme.of(context);
    final categoryTextStyle = theme.textTheme.titleSmall;
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

    Widget buildThemeModeSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionHeader("Theme mode"),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                  label: Text('System', style: Theme.of(context).textTheme.bodySmall),
                  showCheckmark: false,
                  selected: applicationState.themeMode == ThemeMode.system,
                  onSelected: (_) => applicationState.changeThemeMode(ThemeMode.system),
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
              ChoiceChip(
                label: Text('Light', style: Theme.of(context).textTheme.bodySmall),
                showCheckmark: false,
                selected: applicationState.themeMode == ThemeMode.light,
                onSelected: (_) => applicationState.changeThemeMode(ThemeMode.light),
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              ChoiceChip(
                label: Text('Dark', style: Theme.of(context).textTheme.bodySmall),
                showCheckmark: false,
                selected: applicationState.themeMode == ThemeMode.dark,
                onSelected: (_) => applicationState.changeThemeMode(ThemeMode.dark),
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
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
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: CodeEditor.values
                .map((editor) => ChoiceChip(
                      label: Text(getEditorName(editor), style: Theme.of(context).textTheme.bodySmall),
                      showCheckmark: false,
                      selected: applicationState.defaultCodeEditor == editor,
                      onSelected: (_) => applicationState.changeDefaultCodeEditor(editor),
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ))
                .toList(),
          ),
        ],
      );
    }

    Widget buildDocumentHierarchySection() {
      return Row(
        children: [
          Text("Show document hierarchy", style: categoryTextStyle),
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
                Divider(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5), height: 36),
                buildDefaultCodeEditorSection(),
                Divider(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5), height: 36),
                buildDocumentHierarchySection(),
                Divider(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5), height: 36),
                const _PortSettingSection(),
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

class _PortSettingSection extends ConsumerStatefulWidget {
  const _PortSettingSection();

  @override
  ConsumerState<_PortSettingSection> createState() => _PortSettingSectionState();
}

class _PortSettingSectionState extends ConsumerState<_PortSettingSection> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final port = ref.read(applicationStateProvider).communicationPort;
    _controller = TextEditingController(text: port.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _applyPort() {
    final provider = ref.read(applicationStateProvider);
    final finalPort = ApplicationStateProvider.sanitizePortNumber(_controller.text);
    _controller.text = finalPort.toString();
    provider.changeCommunicationPort(finalPort);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canBeEdited = ref.watch(
      applicationStateProvider.select((x) => x.currentMode == ApplicationMode.welcomeScreen),
    );

    return Row(
      children: [
        Text("Connection port", style: theme.textTheme.titleSmall),
        const Spacer(),
        SizedBox(
          width: 65,
          child: TextField(
            controller: _controller,
            enabled: canBeEdited,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.end,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onTapOutside: (_) {
              FocusScope.of(context).unfocus();
              _applyPort();
            },
            onSubmitted: (_) => _applyPort(),
          ),
        ),
      ],
    );
  }
}
