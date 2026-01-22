import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questpdf_companion/shared/font_awesome_icons.dart';
import 'package:window_manager/window_manager.dart';

class ApplicationTitlebarCloseButton extends ConsumerWidget {
  const ApplicationTitlebarCloseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonStyle = ButtonStyle(
        visualDensity: VisualDensity.compact,
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        iconColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onSurfaceVariant),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) =>
            states.contains(WidgetState.hovered) ? Theme.of(context).colorScheme.surfaceContainerHighest : null));

    final closeButtonStyle = buttonStyle.copyWith(
      animationDuration: Duration.zero,
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.hovered)) {
          return Colors.red;
        }
        return Colors.transparent;
      }),
      iconColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.hovered)) {
          return Colors.white;
        }
        return Theme.of(context).colorScheme.onSurfaceVariant;
      }),
    );

    return Row(spacing: 8, children: [
      IconButton(icon: Icon(FontAwesomeIcons.minimize, size: 20), style: buttonStyle, onPressed: windowManager.minimize),
      IconButton(
          icon: Icon(FontAwesomeIcons.maximize, size: 20),
          style: buttonStyle,
          onPressed: () async {
            if (await windowManager.isMaximized()) {
              await windowManager.unmaximize();
            } else {
              await windowManager.maximize();
            }
          }),
      IconButton(icon: Icon(FontAwesomeIcons.close, size: 20), style: closeButtonStyle, onPressed: windowManager.close)
    ]);
  }
}
