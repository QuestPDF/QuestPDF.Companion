import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:process_run/process_run.dart';

import '../areas/application/state/application_state_provider.dart';

Future openSourceCodePathInEditor(CodeEditor editor, String filePath, int lineNumber) async {
  if (filePath.isNullOrEmpty) return;

  final shell = Shell(throwOnError: true, runInShell: true);
  final codeEditor = applicationStateProviderInstance.defaultCodeEditor;

  if (codeEditor == CodeEditor.rider) await shell.run('rider --line $lineNumber $filePath');

  if (codeEditor == CodeEditor.visualCode) await shell.run('code -g $filePath:$lineNumber');

  if (codeEditor == CodeEditor.visualStudio)
    await shell.run('devenv /Command "File.OpenFile $filePath" /Edit $filePath:$lineNumber');
}

Future tryOpenSourceCodePathInEditor(BuildContext context, CodeEditor editor, String filePath, int lineNumber) async {
  void showExceptionMessage() {
    if (!context.mounted) return;

    final backgroundColor = Theme.of(context).colorScheme.error;
    final textColor = Theme.of(context).colorScheme.onError;
    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor);

    final message = "Unable to open the source code in ${getEditorName(editor)}. "
        "Please ensure that the editor is installed correctly and can be launched from the command line (it is added to the PATH environment variable). "
        "Alternatively, you can change the default editor in the application settings.";

    final snackBar = SnackBar(backgroundColor: backgroundColor, content: Text(message, style: textStyle));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  try {
    await openSourceCodePathInEditor(editor, filePath, lineNumber);
  } catch (e) {
    showExceptionMessage();
  }
}

String getEditorName(CodeEditor editor) {
  if (editor == CodeEditor.rider) return 'Rider';

  if (editor == CodeEditor.visualCode) return 'Visual Code';

  if (editor == CodeEditor.visualStudio) return 'Visual Studio';

  return 'Unknown';
}
