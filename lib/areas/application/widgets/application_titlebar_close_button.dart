import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:window_manager/window_manager.dart';

class ApplicationTitlebarCloseButton extends ConsumerWidget {
  const ApplicationTitlebarCloseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        icon: Icon(Symbols.close_rounded, color: Theme.of(context).colorScheme.onSurfaceVariant),
        onPressed: windowManager.close);
  }
}
