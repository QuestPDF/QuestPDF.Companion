import 'package:flutter/material.dart';
import 'package:questpdf_companion/areas/settings/settings_card.dart';

class SettingsViewLayout extends StatelessWidget {
  const SettingsViewLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Center(
          child: Container(
              margin: const EdgeInsets.all(24),
              constraints: const BoxConstraints(maxWidth: 400),
              child: const SettingsCard()),
        ),
      ),
    );
  }
}
