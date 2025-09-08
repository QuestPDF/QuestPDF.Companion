import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

import '../state/application_state_provider.dart';
import 'application_titlebar_card.dart';

class ApplicationTitlebarHotReloadWarning extends ConsumerWidget {
  const ApplicationTitlebarHotReloadWarning({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDocumentHotReloaded = ref
        .watch(applicationStateProvider.select((x) => x.isDocumentHotReloaded));
    const detailsUrl =
        "https://www.questpdf.com/companion/warnings.html#hot-reload";

    return ApplicationTitlebarCard(
      isVisible: isDocumentHotReloaded,
      icon: Symbols.autorenew_rounded,
      emphasized: true,
      emphasisColor: Colors.orange,
      title: "Code-navigation Degraded",
      content: const [
        "When using hot-reload, the code-navigation features are simplified. To take full advantage of this feature, please use dotnet watch.",
      ],
      actions: const [
        ApplicationTitlebarCardAction(label: "Learn More", url: detailsUrl),
      ],
      onClicked: () => launchUrl(Uri.parse(detailsUrl)),
    );
  }
}
