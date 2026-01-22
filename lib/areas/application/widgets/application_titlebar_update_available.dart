import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questpdf_companion/areas/application/state/application_version_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/font_awesome_icons.dart';
import 'application_titlebar_card.dart';

class ApplicationTitlebarUpdateAvailable extends ConsumerWidget {
  const ApplicationTitlebarUpdateAvailable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationVersion = ref.watch(applicationVersionProvider);

    final currentVersion = applicationVersion.currentApplicationVersion?.text ?? "Unknown";
    final latestVersion = applicationVersion.latestApplicationVersion?.text ?? "Unknown";

    const detailsUrl = "https://www.questpdf.com/companion/download.html";

    return ApplicationTitlebarCard(
      isVisible: applicationVersion.isUpdateAvailable,
      icon: FontAwesomeIcons.cloudArrowUp,
      emphasized: true,
      emphasisColor: Colors.blue,
      title: "Update Available",
      content: [
        "Please consider updating the application to receive the latest features and improvements.",
        "$currentVersion → $latestVersion"
      ],
      actions: const [
        ApplicationTitlebarCardAction(label: "Download", url: detailsUrl),
      ],
      onClicked: () => launchUrl(Uri.parse(detailsUrl)),
    );
  }
}
