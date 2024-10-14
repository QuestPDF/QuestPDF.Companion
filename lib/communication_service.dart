import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:questpdf_companion/areas/application/models/application_notify_command.dart';
import 'package:questpdf_companion/areas/application/state/application_state_provider.dart';
import 'package:questpdf_companion/areas/document_hierarchy/models/document_structure.dart';
import 'package:questpdf_companion/areas/document_hierarchy/state/document_hierarchy_provider.dart';
import 'package:questpdf_companion/areas/document_hierarchy/state/document_hierarchy_search_state.dart';
import 'package:questpdf_companion/areas/generic_exception/generic_exception_view_state_provider.dart';

import 'areas/application/models/application_supported_api_response.dart';
import 'areas/document_hierarchy/models/page_snapshot_index.dart';
import 'areas/document_hierarchy/state/document_layout_error_provider.dart';
import 'areas/document_preview/models/update_page_snapshots_command.dart';
import 'areas/document_preview/state/document_viewer_state_provider.dart';
import 'areas/generic_exception/models/show_generic_exception_command.dart';

const communicationServiceDefaultPort = 12500;

final communicationServiceInstance = CommunicationService();

class CommunicationService {
  DateTime? _lastCommunication;

  HttpServer? server;

  CommunicationService() {
    Timer.periodic(const Duration(milliseconds: 1000), (x) => _checkConnection());
  }

  Future tryToStartTheServer(int port) async {
    try {
      await startServer(port);
    } catch (e) {
      applicationStateProviderInstance.changeMode(ApplicationMode.communicationError);
    }
  }

  Future startServer(int port) async {
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);

    await for (HttpRequest request in server!) {
      if (request.uri.path == '/ping' && request.method == 'GET') _handlePingRequest(request);

      if (request.uri.path == '/version' && request.method == 'GET') _handleVersionRequest(request);

      if (request.uri.path == '/v2/notify' && request.method == 'POST') _handleNotifyRequest(request);

      if (request.uri.path == '/v2/documentPreview/update' && request.method == 'POST') _handlePreviewUpdate(request);

      if (request.uri.path == '/v2/documentPreview/getRenderingRequests' && request.method == 'GET')
        _handleGetRenderingRequests(request);

      if (request.uri.path == '/v2/documentPreview/provideRenderedImages' && request.method == 'POST')
        _handleProvideRenderedImages(request);

      if (request.uri.path == '/v2/genericException/show' && request.method == 'POST') _handleGenericException(request);
    }
  }

  Future stopServer() async {
    await server?.close(force: true);
    server = null;
  }

  void _checkConnection() {
    if (_lastCommunication == null) return;

    if (DateTime.now().difference(_lastCommunication!).inSeconds < 1) return;

    _lastCommunication = null;
    applicationStateProviderInstance.changeMode(ApplicationMode.welcomeScreen);
  }

  void _handlePingRequest(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.ok
      ..close();
  }

  Future<void> _handleNotifyRequest(HttpRequest request) async {
    _lastCommunication = DateTime.now();

    final content = await utf8.decoder.bind(request).join();
    final notifyCommand = ApplicationNotifyCommand.fromJson(jsonDecode(content));

    applicationStateProviderInstance.setCurrentLicense(notifyCommand.license);

    request.response
      ..statusCode = HttpStatus.ok
      ..close();
  }

  void _handleVersionRequest(HttpRequest request) {
    final response = ApplicationSupportedApiResponse([2]);

    request.response
      ..headers.contentType = ContentType.text
      ..headers.contentType = ContentType.json
      ..write(jsonEncode(response.toJson()))
      ..close();
  }

  Future<void> _handlePreviewUpdate(HttpRequest request) async {
    final content = await utf8.decoder.bind(request).join();
    final documentStructure = DocumentStructure.fromJson(jsonDecode(content));

    Future.microtask(() {
      documentPreviewImageCacheStateInstance.updateDocumentStructure(documentStructure.pages);
      documentHierarchyProviderInstance.setHierarchy(documentStructure.hierarchy);
      documentHierarchySearchStateInstance.reset();
      documentLayoutErrorProviderInstance.update();

      applicationStateProviderInstance.changeMode(ApplicationMode.documentPreview);
      applicationStateProviderInstance.checkIfDisplayComplexDocumentWarningBasedOnJsonLength(content.length);
      applicationStateProviderInstance.setDocumentAsHotReloaded(documentStructure.isDocumentHotReloaded);
    });

    request.response
      ..statusCode = HttpStatus.ok
      ..close();
  }

  void _handleGetRenderingRequests(HttpRequest request) async {
    List<PageSnapshotIndex> neededImages = [];

    for (int i = 0; i < 100; i++) {
      neededImages = documentPreviewImageCacheStateInstance.getNeededImages();

      if (neededImages.isNotEmpty) break;

      await Future.delayed(const Duration(milliseconds: 25));
    }

    request.response
      ..headers.contentType = ContentType.json
      ..write(jsonEncode(neededImages))
      ..close();
  }

  Future<void> _handleProvideRenderedImages(HttpRequest request) async {
    final content = await utf8.decoder.bind(request).join();

    final renderedList = UpdatePageSnapshotsCommand.fromJson(jsonDecode(content)).pages;

    documentPreviewImageCacheStateInstance.addImages(renderedList);

    request.response
      ..statusCode = HttpStatus.ok
      ..close();
  }

  Future<void> _handleGenericException(HttpRequest request) async {
    final content = await utf8.decoder.bind(request).join();
    final genericException = ShowGenericExceptionCommand.fromJson(jsonDecode(content));

    applicationStateProviderInstance.changeMode(ApplicationMode.genericException);
    genericExceptionViewStateInstance.setException(genericException);

    request.response
      ..statusCode = HttpStatus.ok
      ..close();
  }
}
