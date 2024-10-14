import 'dart:math';

import 'package:flutter/material.dart';

class WelcomeViewHeader extends StatelessWidget {
  const WelcomeViewHeader({super.key});

  static final Image libraryLogo = Image.asset('assets/questpdf-logo.png');

  @override
  Widget build(BuildContext context) {
    const libraryTitleGradient =
        LinearGradient(colors: [Color(0xFF05D9FF), Color(0xFF2680FF)], transform: GradientRotation(pi / 3));

    final libraryTitleStyle =
        Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white);

    final applicationTitleStyle =
        Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 72, child: libraryLogo),
        const SizedBox(width: 24),
        Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          ShaderMask(
              shaderCallback: (bounds) {
                return libraryTitleGradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                );
              },
              child: Text("QuestPDF", style: libraryTitleStyle)),
          Text("Companion", style: applicationTitleStyle)
        ])
      ],
    );
  }
}
