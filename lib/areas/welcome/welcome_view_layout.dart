import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:questpdf_companion/areas/welcome/welcome_view_button.dart';
import 'package:questpdf_companion/areas/welcome/welcome_view_header.dart';
import 'package:questpdf_companion/areas/welcome/welcome_view_version.dart';
import 'package:url_launcher/url_launcher.dart';

import '../application/state/application_state_provider.dart';

class WelcomeViewLayout extends StatelessWidget {
  const WelcomeViewLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxWidth: 275),
            child: Column(children: [
              const WelcomeViewHeader(),
              const SizedBox(height: 32),
              WelcomeViewButton(
                  title: "Introduction",
                  icon: Symbols.rocket_launch_rounded,
                  onClick: () => openUrl("https://www.questpdf.com/companion/usage.html")),
              const SizedBox(height: 8),
              WelcomeViewButton(
                  title: "Application Features",
                  icon: Symbols.menu_book_rounded,
                  onClick: () => openUrl("https://www.questpdf.com/companion/features.html")),
              const SizedBox(height: 8),
              WelcomeViewButton(
                  title: "Software License",
                  icon: Symbols.license_rounded,
                  onClick: () => openUrl("https://www.questpdf.com/license/")),
              const SizedBox(height: 8),
              WelcomeViewButton(
                  title: "Settings",
                  icon: Symbols.settings_rounded,
                  onClick: () => applicationStateProviderInstance.changeMode(ApplicationMode.settings)),
              const SizedBox(height: 16),
              const WelcomeViewVersion()
            ]),
          ),
        ),
      ),
    );
  }

  static void openUrl(String url) {
    launchUrl(Uri.parse(url));
  }
}
