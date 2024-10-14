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

  applicationStateProviderInstance.loadDefaultSettings();

  Future(() {
    final communicationPort = applicationStateProviderInstance.communicationPort;
    communicationServiceInstance.tryToStartTheServer(communicationPort);
  });

  runApp(const ProviderScope(child: QuestPdfCompanionApp()));
}

class QuestPdfCompanionApp extends ConsumerWidget {
  const QuestPdfCompanionApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(applicationStateProvider.select((x) => x.themeMode));

    return MaterialApp(
        title: 'QuestPDF Companion',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0e6bfb)),
            visualDensity: VisualDensity.compact),
        darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0e6bfb), brightness: Brightness.dark),
            visualDensity: VisualDensity.compact),
        themeMode: themeMode,
        home: const ApplicationLayout(),
        showPerformanceOverlay: false,
        debugShowCheckedModeBanner: false);
  }
}
