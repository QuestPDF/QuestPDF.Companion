import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../shared/open_source_code_path_in_editor.dart';
import '../../../shared/source_code_visualization.dart';
import '../../../typography.dart';
import '../../application/state/application_state_provider.dart';
import '../models/generic_exception_stack_frame.dart';

class GenericExceptionStackFramePreview extends StatefulWidget {
  const GenericExceptionStackFramePreview({super.key, required this.stackFrame, required this.isExpanded});

  final GenericExceptionStackFrame stackFrame;
  final bool isExpanded;

  @override
  State<GenericExceptionStackFramePreview> createState() => GenericExceptionStackFramePreviewState();
}

class GenericExceptionStackFramePreviewState extends State<GenericExceptionStackFramePreview> {
  bool? isExpanded;

  @override
  Widget build(BuildContext context) {
    isExpanded ??= widget.isExpanded;

    const contentPadding = 16.0;

    final stackFrame = widget.stackFrame;

    final sourceCodeIsAvailable = stackFrame.fileName != null && stackFrame.lineNumber != null;

    Widget buildStackFrameDescription() {
      final primaryStyle = Theme.of(context).textTheme.bodyMedium;
      final secondaryTextStyle = primaryStyle?.copyWith(
          color: primaryStyle.color?.withAlpha(160), fontWeight: FontWeightOptimizedForOperatingSystem.normal);

      final regex = RegExp(
          r'^(?<namespace>(?:\w+\.)+)(?<className>[\w\[\]\<\>\$\|]+)\.(?<methodName>[\w\[\]\<\>\$\|]+)(?<arguments>(\(.*)\))$');

      final match = regex.firstMatch(stackFrame.codeLocation);

      if (match == null) return Text(stackFrame.codeLocation, style: secondaryTextStyle);

      return RichText(
          text: TextSpan(children: [
        TextSpan(text: match.namedGroup('namespace'), style: secondaryTextStyle),
        TextSpan(text: match.namedGroup('className'), style: primaryStyle),
        TextSpan(text: '.', style: secondaryTextStyle),
        TextSpan(text: match.namedGroup('methodName'), style: primaryStyle),
        TextSpan(text: match.namedGroup('arguments'), style: secondaryTextStyle),
      ]));
    }

    Widget buildFileVisualization() {
      if (isExpanded != true) return const SizedBox();

      if (!sourceCodeIsAvailable) return const SizedBox();

      return Padding(
        padding: const EdgeInsets.only(top: 12),
        child: SourceCodeVisualization(
            filePath: stackFrame.fileName!,
            highlightLineNumber: stackFrame.lineNumber!,
            showLinesBuffer: 9,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
            highlightColor: Theme.of(context).colorScheme.surfaceContainerLow),
      );
    }

    Widget buildSourceCodeVisibilityButton() {
      if (stackFrame.fileName == null) return const SizedBox();
      if (stackFrame.lineNumber == null) return const SizedBox();

      return IconButton(
          icon: isExpanded!
              ? const Icon(Symbols.keyboard_arrow_up_rounded)
              : const Icon(Symbols.keyboard_arrow_down_rounded),
          color: Theme.of(context).colorScheme.primary,
          tooltip: 'Show source-code snippet',
          onPressed: () => setState(() {
                isExpanded = !isExpanded!;
              }));
    }

    final separatorColor = Theme.of(context).colorScheme.outlineVariant;

    final onTapHandler = (stackFrame.fileName == null)
        ? null
        : () => tryOpenSourceCodePathInEditor(
            context, applicationStateProviderInstance.defaultCodeEditor, stackFrame.fileName!, stackFrame.lineNumber!);

    return InkWell(
        onTap: onTapHandler,
        child: Container(
          decoration: BoxDecoration(border: Border(top: BorderSide(width: 1, color: separatorColor))),
          padding: const EdgeInsets.all(contentPadding),
          child: Column(children: [
            Row(children: [
              Expanded(child: buildStackFrameDescription()),
              buildSourceCodeVisibilityButton(),
            ]),
            buildFileVisualization(),
          ]),
        ));
  }
}
