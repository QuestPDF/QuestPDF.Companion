import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questpdf_companion/areas/application/state/application_state_provider.dart';
import 'package:questpdf_companion/communication_service.dart';
import 'package:questpdf_companion/typography.dart';

import '../../shared/font_awesome_icons.dart';

class WelcomeViewPortCard extends ConsumerStatefulWidget {
  const WelcomeViewPortCard({super.key});

  @override
  ConsumerState<WelcomeViewPortCard> createState() => _WelcomeViewPortCardState();
}

class _WelcomeViewPortCardState extends ConsumerState<WelcomeViewPortCard> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final port = ref.read(applicationStateProvider).communicationPort;
    _controller = TextEditingController(text: port.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _applyPort() {
    final provider = ref.read(applicationStateProvider);
    provider.changeCommunicationPort(_controller.text);
    _controller.text = provider.communicationPort.toString();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final port = ref.watch(applicationStateProvider.select((x) => x.communicationPort));
    final status = ref.watch(applicationStateProvider.select((x) => x.communicationStatus));

    if (int.tryParse(_controller.text) != port && !_focusNode.hasFocus) {
      _controller.text = port.toString();
    }

    final Color accentColor;
    final String statusLabel;
    final String statusHint;

    switch (status) {
      case CommunicationStatus.starting:
        accentColor = Colors.grey;
        statusLabel = "Starting";
        statusHint = "Please wait while the server starts on the configured port.";
        break;
      case CommunicationStatus.active:
        accentColor = Colors.green;
        statusLabel = "Listening";
        statusHint = "Run 'dotnet watch' in your .NET project to connect.";
        break;
      case CommunicationStatus.error:
        accentColor = Colors.red;
        statusLabel = "Error";
        statusHint = "The port may already be in use. Try a different port number.";
        break;
    }

    return Card(
      clipBehavior: Clip.hardEdge,
      color: theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(FontAwesomeIcons.terminal, size: 16, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: 10),
                Text(
                  "Communication Port",
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeightOptimizedForOperatingSystem.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text("Port:", style: theme.textTheme.bodyMedium),
                const SizedBox(width: 12),
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    style: theme.textTheme.bodyMedium,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onSubmitted: (_) => _applyPort(),
                    onTapOutside: (_) => _applyPort(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              "Range: 0–65535. Default: $communicationServiceDefaultPort.",
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
            ),
            const SizedBox(height: 16),
            _buildStatusAlert(theme, status, accentColor, statusLabel, statusHint),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusAlert(ThemeData theme, CommunicationStatus status, Color accentColor, String label, String hint) {
    final bool isError = status == CommunicationStatus.error;
    final Color backgroundColor = isError ? theme.colorScheme.errorContainer : theme.colorScheme.surfaceContainerHighest;
    final Color textColor = isError ? theme.colorScheme.onErrorContainer : theme.colorScheme.onSurface;
    final Color secondaryTextColor = isError ? theme.colorScheme.onErrorContainer : theme.colorScheme.onSurfaceVariant;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border(left: BorderSide(color: accentColor, width: 6)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeightOptimizedForOperatingSystem.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              hint,
              style: theme.textTheme.bodySmall?.copyWith(color: secondaryTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
