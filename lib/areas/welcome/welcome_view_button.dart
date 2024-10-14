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
        child: InkWell(
            onTap: onClick,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(icon, size: 24, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  const SizedBox(width: 16),
                  Flexible(
                    child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ],
              ),
            )));
  }
}
