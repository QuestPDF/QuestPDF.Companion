import 'package:flutter/material.dart';
import 'package:questpdf_companion/areas/application/state/application_state_provider.dart';

class ApplicationCommunicationError extends StatelessWidget {
  const ApplicationCommunicationError({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onErrorContainer;

    final titleTextStyle = Theme.of(context).textTheme.titleSmall?.copyWith(color: textColor);
    final descriptionTextStyle = Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor);

    final port = applicationStateProviderInstance.communicationPort;

    return Center(
      child: SizedBox(
        width: 400,
        child: IntrinsicHeight(
          child: Card(
            color: Theme.of(context).colorScheme.errorContainer,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Communication error", style: titleTextStyle),
                  const SizedBox(height: 8),
                  Text(
                      "An error occurred while attempting to start or run the communication server on port $port. Please ensure that no other instance of the application is currently running, and check for any potential issue.",
                      style: descriptionTextStyle)
                ])),
          ),
        ),
      ),
    );
  }
}
