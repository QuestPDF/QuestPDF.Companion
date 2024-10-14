import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/darcula.dart';
import 'package:flutter_highlight/themes/vs.dart';

class SourceCodeVisualization extends StatefulWidget {
  final String filePath;
  final int highlightLineNumber;
  final int showLinesBuffer;
  final Color backgroundColor;
  final Color highlightColor;

  const SourceCodeVisualization(
      {super.key,
      required this.filePath,
      required this.highlightLineNumber,
      required this.showLinesBuffer,
      required this.backgroundColor,
      required this.highlightColor});

  @override
  State<SourceCodeVisualization> createState() => SourceCodeVisualizationState();
}

class SourceCodeVisualizationState extends State<SourceCodeVisualization> {
  String? sourceCode;
  bool? isSuccess;

  @override
  void initState() {
    Future(loadSourceCode);
    super.initState();
  }

  Future loadSourceCode() async {
    try {
      final fileContent = File(widget.filePath).readAsStringSync();

      setState(() {
        sourceCode = fileContent;
        isSuccess = true;
      });
    } catch (e) {
      isSuccess = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isSuccess == false) return buildFailureMessage();

    return buildPreview(context);
  }

  Widget buildFailureMessage() {
    final backgroundColor = Theme.of(context).colorScheme.error;
    final textColor = Theme.of(context).colorScheme.onError;
    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor);

    return Container(
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(12),
      child: Text('Cannot load source code', style: textStyle),
    );
  }

  Widget buildPreview(BuildContext context) {
    final lines =
        sourceCode?.split('\n') ?? List.generate(widget.highlightLineNumber + widget.showLinesBuffer, (index) => '');

    final lineNumberBegin = (widget.highlightLineNumber - widget.showLinesBuffer).clamp(1, lines.length);
    final lineNumberEnd = (widget.highlightLineNumber + widget.showLinesBuffer).clamp(1, lines.length);

    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final sourceTheme = isDarkTheme ? darculaTheme : vsTheme;

    final theme = Map<String, TextStyle>.from(sourceTheme);
    theme["root"] = TextStyle(color: theme["root"]!.color, backgroundColor: Colors.transparent);

    Widget generateCodeLine(int lineNumber) {
      final isHighlighted = lineNumber == widget.highlightLineNumber;
      const codeStyle = TextStyle(fontFamily: 'JetBrains Mono', fontSize: 12);

      return Container(
        color: isHighlighted ? widget.highlightColor : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(children: [
          SizedBox(
              width: 30, child: Text(lineNumber.toString(), style: codeStyle.copyWith(color: theme["root"]!.color))),
          const SizedBox(width: 8),
          SizedBox(
            width: sourceCode == null ? 600 : null,
            child: HighlightView(
              lines[lineNumber - 1],
              language: 'cs',
              theme: theme,
              textStyle: codeStyle,
            ),
          )
        ]),
      );
    }

    final codeLines = List.generate(lineNumberEnd - lineNumberBegin + 1, (index) => lineNumberBegin + index)
        .map(generateCodeLine)
        .toList();

    // it is okay to observer overflow here
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: widget.backgroundColor, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: IntrinsicWidth(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: codeLines)),
        ));
  }
}
