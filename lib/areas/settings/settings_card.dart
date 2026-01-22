import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questpdf_companion/areas/application/state/application_state_provider.dart';
import 'package:questpdf_companion/shared/open_source_code_path_in_editor.dart';

import '../../shared/font_awesome_icons.dart';
import '../../typography.dart';

class SettingsCard extends ConsumerStatefulWidget {
  const SettingsCard({super.key});

  @override
  SettingsCardState createState() => SettingsCardState();
}

class SettingsCardState extends ConsumerState<SettingsCard> {
  final TextEditingController communicationPortTextEditingController = TextEditingController();
  final FocusNode communicationPortTextFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    communicationPortTextFocusNode.addListener(updatePortNumber);
  }

  @override
  void dispose() {
    communicationPortTextEditingController.dispose();
    communicationPortTextFocusNode.dispose();
    super.dispose();
  }

  void updatePortNumber() {
    Future(() {
      applicationStateProviderInstance.changeCommunicationPort(communicationPortTextEditingController.text);
      communicationPortTextEditingController.text = applicationStateProviderInstance.communicationPort.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final applicationState = ref.watch(applicationStateProvider);
    communicationPortTextEditingController.text = applicationStateProviderInstance.communicationPort.toString();

    final titleTextStyle = Theme.of(context).textTheme.titleMedium;
    final categoryTextStyle = Theme.of(context).textTheme.titleSmall;
    final labelTextStyle =
        Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeightOptimizedForOperatingSystem.normal);

    Widget buildThemeModeSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Theme mode", style: categoryTextStyle),
          const SizedBox(height: 8),
          SegmentedButton(
              segments: [
                ButtonSegment(
                    value: ThemeMode.system,
                    label: Text('System', style: labelTextStyle),
                    icon: Icon(FontAwesomeIcons.desktop)),
                ButtonSegment(
                    value: ThemeMode.light, label: Text('Light', style: labelTextStyle), icon: Icon(FontAwesomeIcons.sun)),
                ButtonSegment(
                    value: ThemeMode.dark, label: Text('Dark', style: labelTextStyle), icon: Icon(FontAwesomeIcons.moon))
              ],
              selected: {
                applicationState.themeMode
              },
              multiSelectionEnabled: false,
              emptySelectionAllowed: false,
              showSelectedIcon: false,
              onSelectionChanged: (x) => applicationState.changeThemeMode(x.first))
        ],
      );
    }

    Widget buildDefaultCodeEditorSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Default code editor", style: categoryTextStyle),
          const SizedBox(height: 8),
          SegmentedButton(
              segments: CodeEditor.values
                  .map((x) => ButtonSegment(value: x, label: Text(getEditorName(x), style: labelTextStyle)))
                  .toList(),
              selected: {applicationState.defaultCodeEditor},
              multiSelectionEnabled: false,
              emptySelectionAllowed: false,
              showSelectedIcon: false,
              onSelectionChanged: (x) => applicationState.changeDefaultCodeEditor(x.first))
        ],
      );
    }

    Widget buildCommunicationPortSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Communication port (localhost)", style: categoryTextStyle),
          const SizedBox(height: 8),
          SizedBox(
              width: 80,
              child: TextField(
                  focusNode: communicationPortTextFocusNode,
                  controller: communicationPortTextEditingController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      hintText: "12500",
                      hintStyle: const TextStyle(fontWeight: FontWeight.normal))))
        ],
      );
    }

    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Settings",
            style: titleTextStyle,
          ),
          const SizedBox(height: 24),
          buildThemeModeSection(),
          const SizedBox(height: 24),
          buildDefaultCodeEditorSection(),
          const SizedBox(height: 24),
          buildCommunicationPortSection(),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              child: const Text('Save'),
              onPressed: () => applicationStateProviderInstance.changeMode(ApplicationMode.welcomeScreen),
            ),
          )
        ],
      ),
    ));
  }
}

enum Calendar { day, week, month, year }
