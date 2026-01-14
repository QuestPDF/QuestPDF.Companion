import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

import '../state/application_state_provider.dart';
import 'application_titlebar_card.dart';

class ApplicationTitlebarComplexDocumentWarning extends ConsumerWidget {
  const ApplicationTitlebarComplexDocumentWarning({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isComplexDocument = ref.watch(applicationStateProvider.select((x) => x.isComplexDocument));
    const detailsUrl = "https://www.questpdf.com/companion/warnings.html#complex-document";

    return ApplicationTitlebarCard(
      isVisible: isComplexDocument,
      icon: Symbols.speed_rounded,
      emphasized: true,
      emphasisColor: Colors.orange,
      title: "Performance Degraded",
      content: const [
        "Your document contains complex content. The hot-reload performance may be impacted. Please consider developing with a simpler document.",
      ],
      actions: const [
        ApplicationTitlebarCardAction(label: "Learn More", url: detailsUrl),
      ],
      onClicked: () => launchUrl(Uri.parse(detailsUrl)),
    );
  }
}
