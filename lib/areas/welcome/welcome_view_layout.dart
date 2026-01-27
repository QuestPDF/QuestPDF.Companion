import 'package:flutter/material.dart';
import 'package:questpdf_companion/areas/welcome/welcome_view_button.dart';
import 'package:questpdf_companion/areas/welcome/welcome_view_port_card.dart';
import 'package:questpdf_companion/areas/welcome/welcome_view_version.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/font_awesome_icons.dart';

class WelcomeViewLayout extends StatelessWidget {
  const WelcomeViewLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(children: [
              const WelcomeViewPortCard(),
              const SizedBox(height: 24),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  WelcomeViewButton(
                      title: "Introduction",
                      icon: FontAwesomeIcons.rocket,
                      onClick: () => openUrl("https://www.questpdf.com/companion/usage.html")),
                  WelcomeViewButton(
                      title: "Features",
                      icon: FontAwesomeIcons.book,
                      onClick: () => openUrl("https://www.questpdf.com/companion/features.html")),
                  WelcomeViewButton(
                      title: "License",
                      icon: FontAwesomeIcons.certificate,
                      onClick: () => openUrl("https://www.questpdf.com/license/")),
                ],
              ),
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
