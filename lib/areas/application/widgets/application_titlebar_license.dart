import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:questpdf_companion/areas/application/state/application_state_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/license_details.dart';
import 'application_titlebar_card.dart';

class ApplicationTitlebarLicense extends ConsumerWidget {
  const ApplicationTitlebarLicense({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLicense = ref.watch(applicationStateProvider.select((x) => x.currentLicense));

    if (currentLicense == null) return const SizedBox();

    final licenseDetails = getLicenseDetails(currentLicense);

    return ApplicationTitlebarCard(
      isVisibile: true,
      icon: Symbols.license_rounded,
      emphasized: true,
      emphasisColor: licenseDetails.indicatorColor,
      title: "Your License: ${licenseDetails.title}",
      content: [licenseDetails.description],
      actions: const [
        ApplicationTitlebarCardAction(label: "Guide", url: licenseSelectionGuideUrl),
        ApplicationTitlebarCardAction(label: "Pricing", url: pricingUrl),
      ],
      onClicked: () => launchUrl(Uri.parse(licenseDetails.url)),
    );
  }
}
