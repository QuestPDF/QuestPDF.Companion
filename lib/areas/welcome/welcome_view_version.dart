import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questpdf_companion/areas/application/state/application_version_state.dart';

class WelcomeViewVersion extends ConsumerWidget {
  const WelcomeViewVersion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationVersion = ref.watch(applicationVersionProvider.select((x) => x.currentApplicationVersion));

    return Text(applicationVersion?.text ?? "-",
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant));
  }
}
