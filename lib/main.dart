import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questpdf_companion/areas/application/state/application_state_provider.dart';
import 'package:questpdf_companion/areas/application/widgets/application_layout.dart';
import 'package:window_manager/window_manager.dart';

import 'communication_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: false);
  await windowManager.setMinimumSize(const Size(600, 500));

  Future.microtask(() async {
    await applicationStateProviderInstance.loadDefaultSettings();

    final communicationPort = applicationStateProviderInstance.communicationPort;
    await communicationServiceInstance.tryToStartTheServer(communicationPort);
  });

  runApp(const ProviderScope(child: QuestPdfCompanionApp()));
}

class QuestPdfCompanionApp extends ConsumerWidget {
  const QuestPdfCompanionApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(applicationStateProvider.select((x) => x.themeMode));

    final iconButtonTheme = IconButtonThemeData(
      style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          )),
    );

    return MaterialApp(
        title: 'QuestPDF Companion',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0e6bfb)),
            visualDensity: VisualDensity.compact,
            iconButtonTheme: iconButtonTheme),
        darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0e6bfb), brightness: Brightness.dark),
            visualDensity: VisualDensity.compact,
            iconButtonTheme: iconButtonTheme),
        themeMode: themeMode,
        home: const ApplicationLayout(),
        showPerformanceOverlay: false,
        debugShowCheckedModeBanner: false);
  }
}
