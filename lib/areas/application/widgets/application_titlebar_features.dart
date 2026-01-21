import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/font_awesome_icon.dart';
import 'application_titlebar_card.dart';

class ApplicationTitlebarFeatures extends ConsumerWidget {
  const ApplicationTitlebarFeatures({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const learnMoreUrl = "https://www.questpdf.com/companion/features.html";

    return ApplicationTitlebarCard(
      isVisible: true,
      icon: FontAwesomeIcons.book,
      emphasized: false,
      emphasisColor: Colors.transparent,
      title: "Application Features",
      content: const [
        "This application provides a wide range of features to help you create and manage your PDF documents.",
      ],
      actions: const [
        ApplicationTitlebarCardAction(label: "Learn more", url: learnMoreUrl),
      ],
      onClicked: () => launchUrl(Uri.parse(learnMoreUrl)),
    );
  }
}
