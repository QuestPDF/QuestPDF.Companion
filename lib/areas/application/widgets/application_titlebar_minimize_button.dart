import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:window_manager/window_manager.dart';

class ApplicationTitlebarMinimizeButton extends ConsumerWidget {
  const ApplicationTitlebarMinimizeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        icon: Icon(Symbols.minimize_rounded, color: Theme.of(context).colorScheme.onSurfaceVariant),
        onPressed: windowManager.minimize);
  }
}