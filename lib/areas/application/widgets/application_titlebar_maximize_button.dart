import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:window_manager/window_manager.dart';

class ApplicationTitlebarMaximizeButton extends ConsumerStatefulWidget {
  const ApplicationTitlebarMaximizeButton({super.key});

  @override
  ConsumerState<ApplicationTitlebarMaximizeButton> createState() => _ApplicationTitlebarMaximizeButtonState();
}

class _ApplicationTitlebarMaximizeButtonState extends ConsumerState<ApplicationTitlebarMaximizeButton>
    with WindowListener {
  bool _isMaximized = false;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _updateMaximizedState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowMaximize() {
    setState(() {
      _isMaximized = true;
    });
  }

  @override
  void onWindowUnmaximize() {
    setState(() {
      _isMaximized = false;
    });
  }

  Future<void> _updateMaximizedState() async {
    final isMaximized = await windowManager.isMaximized();
    setState(() {
      _isMaximized = isMaximized;
    });
  }

  Future<void> _toggleMaximize() async {
    if (_isMaximized) {
      await windowManager.unmaximize();
    } else {
      await windowManager.maximize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
            _isMaximized ? Symbols.fullscreen_exit_rounded : Symbols.fullscreen_rounded,
            color: Theme.of(context).colorScheme.onSurfaceVariant),
        onPressed: _toggleMaximize);
  }
}