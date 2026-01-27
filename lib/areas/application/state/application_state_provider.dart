import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questpdf_companion/communication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final applicationStateProviderInstance = ApplicationStateProvider();
final applicationStateProvider = ChangeNotifierProvider((ref) => applicationStateProviderInstance);

enum ApplicationMode { welcomeScreen, documentPreview, genericException }

enum CommunicationStatus { starting, active, error }

enum CodeEditor { rider, visualCode, visualStudio }

enum LicenseType {
  community,
  professional,
  enterprise,
}

class ApplicationStateProvider extends ChangeNotifier {
  SharedPreferences? _prefs;

  ThemeMode themeMode = ThemeMode.system;
  ApplicationMode currentMode = ApplicationMode.welcomeScreen;
  CodeEditor defaultCodeEditor = CodeEditor.visualCode;
  bool showDocumentHierarchy = true;
  int communicationPort = communicationServiceDefaultPort;
  LicenseType? currentLicense;
  CommunicationStatus communicationStatus = CommunicationStatus.starting;
  bool isComplexDocument = false;
  bool isDocumentHotReloaded = false;

  Future loadDefaultSettings() async {
    _prefs ??= await SharedPreferences.getInstance();

    themeMode = ThemeMode.values[_prefs!.getInt('themeMode') ?? 0];
    defaultCodeEditor = CodeEditor.values[_prefs!.getInt('defaultCodeEditor') ?? 0];
    showDocumentHierarchy = _prefs!.getBool('showDocumentHierarchy') ?? true;
    communicationPort = _prefs!.getInt('communicationPort') ?? communicationServiceDefaultPort;

    notifyListeners();
  }

  void setCurrentLicense(LicenseType? license) {
    if (currentLicense == license) return;

    currentLicense = license;
    notifyListeners();
  }

  void changeThemeMode(ThemeMode? mode) {
    themeMode = mode ?? ThemeMode.system;
    _prefs?.setInt('themeMode', themeMode.index);
    notifyListeners();
  }

  void changeDefaultCodeEditor(CodeEditor? editor) {
    defaultCodeEditor = editor ?? CodeEditor.visualCode;
    _prefs?.setInt('defaultCodeEditor', defaultCodeEditor.index);
    notifyListeners();
  }

  void toggleDocumentHierarchyVisibility() {
    showDocumentHierarchy = !showDocumentHierarchy;
    _prefs?.setBool('showDocumentHierarchy', showDocumentHierarchy);
    notifyListeners();
  }

  Future changeCommunicationPort(String portText) async {
    final newPort = int.tryParse(portText)?.clamp(0, 65535) ?? communicationServiceDefaultPort;

    if (communicationPort == newPort) return;

    communicationPort = newPort;
    communicationStatus = CommunicationStatus.starting;
    _prefs?.setInt('communicationPort', communicationPort);

    await communicationServiceInstance.stopServer();
    communicationServiceInstance.tryToStartTheServer(communicationPort);

    notifyListeners();
  }

  void changeCommunicationStatus(CommunicationStatus status) {
    if (communicationStatus == status) return;

    communicationStatus = status;
    notifyListeners();
  }

  void changeMode(ApplicationMode? mode) {
    currentMode = mode ?? ApplicationMode.welcomeScreen;
    notifyListeners();
  }

  void setDocumentAsHotReloaded(bool hotReloaded) {
    isDocumentHotReloaded = hotReloaded;
    notifyListeners();
  }

  void checkIfDisplayComplexDocumentWarningBasedOnJsonLength(int size) {
    isComplexDocument = size > 5 * 1000 * 1000;
    notifyListeners();
  }
}
