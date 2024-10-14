import 'package:flutter/material.dart';
import 'package:questpdf_companion/areas/application/state/application_state_provider.dart';

class LicenseDetails {
  final String title;
  final String description;
  final String url;
  final MaterialColor indicatorColor;

  const LicenseDetails(
      {required this.title, required this.description, required this.url, required this.indicatorColor});
}

const pricingUrl = "https://www.questpdf.com/license/";
const licenseSelectionGuideUrl = "https://www.questpdf.com/license/guide.html";

const communityLicense = LicenseDetails(
    title: "Community MIT",
    description: "Applicable only for companies and individuals with less than 1M USD annual gross revenue.",
    url: "https://www.questpdf.com/license/summary/community.html",
    indicatorColor: Colors.orange);

const professionalLicense = LicenseDetails(
    title: "Professional",
    description:
        "Applicable for individuals and companies with more than 1M USD annual gross revenue and with at most 10 software developers working on software dependent on QuestPDF.",
    url: "https://www.questpdf.com/license/summary/professional.html",
    indicatorColor: Colors.green);

const enterpriseLicense = LicenseDetails(
    title: "Enterprise",
    description:
        "Applicable for individuals and companies with more than 1M USD annual gross revenue and any number of software developers.",
    url: "https://www.questpdf.com/license/summary/enterprise.html",
    indicatorColor: Colors.green);

LicenseDetails getLicenseDetails(LicenseType license) {
  if (license == LicenseType.community) return communityLicense;
  if (license == LicenseType.professional) return professionalLicense;
  if (license == LicenseType.enterprise) return enterpriseLicense;

  return communityLicense;
}
