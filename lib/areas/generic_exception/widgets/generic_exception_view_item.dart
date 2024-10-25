import 'package:flutter/material.dart';
import 'package:questpdf_companion/areas/generic_exception/models/generic_exception_stack_frame.dart';

import '../../../typography.dart';
import 'generic_exception_stack_frame_preview.dart';

class GenericExceptionViewItem extends StatelessWidget {
  const GenericExceptionViewItem({super.key, required this.type, required this.message, required this.stackTrace});

  final String type;
  final String message;
  final List<GenericExceptionStackFrame> stackTrace;

  @override
  Widget build(BuildContext context) {
    const contentPadding = 16.0;

    Widget buildExceptionHeader() {
      final titleTextStyle =
          Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onErrorContainer);

      final descriptionTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onErrorContainer,
          fontWeight: FontWeightOptimizedForOperatingSystem.normal);

      return Container(
        color: Theme.of(context).colorScheme.errorContainer,
        child: Padding(
          padding: const EdgeInsets.all(contentPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type, style: descriptionTextStyle),
              const SizedBox(height: 8),
              Text(message, style: titleTextStyle),
            ],
          ),
        ),
      );
    }

    final firstFrameWithSourceCode = stackTrace.where((x) => x.fileName != null && x.lineNumber != null).firstOrNull;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildExceptionHeader(),
          ...stackTrace
              .map((x) => GenericExceptionStackFramePreview(stackFrame: x, isExpanded: x == firstFrameWithSourceCode)),
        ],
      ),
    );
  }
}
