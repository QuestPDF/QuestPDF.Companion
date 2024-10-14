import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

import 'application_titlebar_card.dart';

class ApplicationTitlebarFeedback extends ConsumerWidget {
  const ApplicationTitlebarFeedback({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const shareUrl =
        "https://github.com/QuestPDF/QuestPDF/issues/new?assignees=&labels=companion-app&projects=&template=companion_app_feedback.md&title=";

    return ApplicationTitlebarCard(
      isVisibile: true,
      icon: Symbols.emoji_emotions_rounded,
      emphasized: false,
      emphasisColor: Colors.transparent,
      title: "Feedback",
      content: const [
        "We are always looking for ways to improve the application. Please share your feedback with us.",
      ],
      actions: const [
        ApplicationTitlebarCardAction(label: "Share", url: shareUrl),
      ],
      onClicked: () => launchUrl(Uri.parse(shareUrl)),
    );
  }
}
