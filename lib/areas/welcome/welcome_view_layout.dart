import 'package:flutter/material.dart';
import 'package:questpdf_companion/areas/welcome/welcome_view_button.dart';
import 'package:questpdf_companion/areas/welcome/welcome_view_version.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/font_awesome_icons.dart';

class WelcomeViewLayout extends StatelessWidget {
  const WelcomeViewLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SizedBox(
        width: 235,
        child: IntrinsicHeight(
          child: Column(
            children: [
              Text("Companion App", style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 24),
              _buildResourcesSection(theme),
              const SizedBox(height: 32),
              const WelcomeViewVersion(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResourcesSection(ThemeData theme) {
    return Column(
      spacing: 8,
      children: [
        WelcomeViewButton(
          label: "Quick Start",
          icon: FontAwesomeIcons.rocket,
          onClick: () => openUrl("https://www.questpdf.com/companion/usage.html"),
        ),
        WelcomeViewButton(
          label: "App features",
          icon: FontAwesomeIcons.book,
          onClick: () => openUrl("https://www.questpdf.com/companion/features.html"),
        ),
        WelcomeViewButton(
          label: "License",
          icon: FontAwesomeIcons.license,
          onClick: () => openUrl("https://www.questpdf.com/license/"),
        ),
      ],
    );
  }

  static void openUrl(String url) {
    launchUrl(Uri.parse(url));
  }
}
