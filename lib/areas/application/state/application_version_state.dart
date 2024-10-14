import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

final applicationVersionProviderInstance = ApplicationStateProvider();
final applicationVersionProvider = ChangeNotifierProvider((ref) => applicationVersionProviderInstance);

class ApplicationStateProvider extends ChangeNotifier {
  ApplicationVersion? currentApplicationVersion;
  ApplicationVersion? latestApplicationVersion;

  bool get isUpdateAvailable => latestApplicationVersion?.isNewerThan(currentApplicationVersion) ?? false;

  ApplicationStateProvider() {
    checkApplicationVersion();
    checkLatestApplicationVersion();
  }

  void checkApplicationVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    currentApplicationVersion = ApplicationVersion.parse(info.version);
    notifyListeners();
  }

  void checkLatestApplicationVersion() async {
    final url = Uri.parse('http://questpdf.com/companion/latest-version');

    try {
      final response = await http.get(url);
      latestApplicationVersion = ApplicationVersion.parse(response.body);
      notifyListeners();
    } catch (e) {
      return null;
    }
  }
}

class ApplicationVersion {
  final int major;
  final int minor;
  final int path;

  String get text => '$major.$minor.$path';

  ApplicationVersion(this.major, this.minor, this.path);

  static ApplicationVersion parse(String version) {
    final parts = version.split('.');
    return ApplicationVersion(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
  }

  bool isNewerThan(ApplicationVersion? other) {
    if (other == null) return false;

    if (major < other.major) return false;
    if (major > other.major) return true;

    if (minor < other.minor) return false;
    if (minor > other.minor) return true;

    return path > other.path;
  }
}
