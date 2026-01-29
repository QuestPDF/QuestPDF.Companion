import 'package:flutter/material.dart';

class WelcomeViewButton extends StatelessWidget {
  const WelcomeViewButton({super.key, required this.icon, required this.label, required this.onClick});

  final IconData icon;
  final String label;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.hardEdge,
      color: theme.cardColor,
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Icon(icon, size: 24),
              const SizedBox(width: 24),
              Text(label, style: theme.textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }
}
