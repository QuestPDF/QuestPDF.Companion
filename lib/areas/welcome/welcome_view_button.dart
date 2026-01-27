import 'package:flutter/material.dart';

class WelcomeViewButton extends StatelessWidget {
  const WelcomeViewButton({super.key, required this.icon, required this.title, required this.onClick});

  final IconData icon;
  final String title;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.hardEdge,
        color: Theme.of(context).cardColor,
        child: InkWell(
            onTap: onClick,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  const SizedBox(width: 10),
                  Text(title, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            )));
  }
}
