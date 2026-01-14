import 'package:flutter/material.dart';

class WelcomeViewHeader extends StatelessWidget {
  const WelcomeViewHeader({super.key});

  static final Image libraryLogoLight = Image.asset('assets/questpdf-logo-light.png');
  static final Image libraryLogoDark = Image.asset('assets/questpdf-logo-dark.png');

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final libraryLogo = isLightTheme ? libraryLogoLight : libraryLogoDark;

    return SizedBox(height: 48, child: libraryLogo);
  }
}
