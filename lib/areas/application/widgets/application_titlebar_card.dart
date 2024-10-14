import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicationTitlebarCardAction {
  final String label;
  final String url;

  const ApplicationTitlebarCardAction({required this.label, required this.url});
}

class ApplicationTitlebarCard extends ConsumerWidget {
  final bool isVisibile;

  final IconData icon;
  final bool emphasized;
  final Color emphasisColor;

  final VoidCallback? onClicked;

  final String title;
  final List<String> content;
  final List<ApplicationTitlebarCardAction> actions;

  const ApplicationTitlebarCard({
    super.key,
    required this.isVisibile,
    required this.icon,
    required this.emphasized,
    required this.emphasisColor,
    required this.onClicked,
    required this.title,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleTextStyle = Theme.of(context).textTheme.titleMedium;
    final contentStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.outline);

    Widget buildTooltipContent() {
      return Container(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Card(
          elevation: 8,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: titleTextStyle),
                  const SizedBox(height: 8),
                  ...content.flatMap((x) => [
                        Text(x, style: contentStyle),
                        const SizedBox(height: 8),
                      ]),
                  if (actions.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: actions.map((action) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: OutlinedButton(
                              onPressed: () => launchUrl(Uri.parse(action.url)), child: Text(action.label)),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              )),
        ),
      );
    }

    Widget buildIndicatorIcon() {
      final iconColor = emphasized ? Colors.white : Theme.of(context).colorScheme.onSurfaceVariant;
      final style = emphasized ? IconButton.styleFrom(backgroundColor: emphasisColor) : IconButton.styleFrom();

      return Padding(
        padding: emphasized ? const EdgeInsets.symmetric(horizontal: 4) : EdgeInsets.zero,
        child: IconButton(
            icon: Icon(icon, color: iconColor),
            visualDensity: emphasized ? VisualDensity.compact : VisualDensity.standard,
            padding: emphasized ? const EdgeInsets.symmetric(vertical: 4, horizontal: 8) : const EdgeInsets.all(0),
            style: style,
            onPressed: onClicked),
      );
    }

    return Visibility(
      visible: isVisibile,
      child: Tooltip(
        richMessage: WidgetSpan(child: IntrinsicWidth(child: buildTooltipContent())),
        padding: EdgeInsets.zero,
        enableTapToDismiss: false,
        decoration: const BoxDecoration(),
        exitDuration: const Duration(milliseconds: 200),
        child: buildIndicatorIcon(),
      ),
    );
  }
}
