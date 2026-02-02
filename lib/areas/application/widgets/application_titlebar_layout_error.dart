import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/font_awesome_icons.dart';
import '../../document_hierarchy/state/document_layout_error_provider.dart';
import 'application_titlebar_card.dart';

class ApplicationTitlebarLayoutError extends ConsumerWidget {
  const ApplicationTitlebarLayoutError({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const learnMoreUrl = "https://www.questpdf.com/concepts/layout-error.html";

    final containsLayoutError = ref.watch(documentLayoutErrorProvider.select((x) => x.containsLayoutError));

    return ApplicationTitlebarCard(
      isVisible: containsLayoutError,
      icon: FontAwesomeIcons.layoutError,
      emphasized: true,
      emphasisColor: Colors.red,
      title: "Layout error detected",
      content: const [
        "The provided document content contains conflicting size constraints.",
        "Please use the layout debugger to identify the issue."
      ],
      actions: const [ApplicationTitlebarCardAction(label: "Learn more", url: learnMoreUrl)],
      onClicked: () => launchUrl(Uri.parse(learnMoreUrl)),
    );
  }
}
