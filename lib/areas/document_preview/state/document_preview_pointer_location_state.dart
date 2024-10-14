import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final documentPreviewPointerLocationStateInstance = DocumentPreviewPointerLocationState();
final documentPreviewPointerLocationStateProvider =
    ChangeNotifierProvider((ref) => documentPreviewPointerLocationStateInstance);

class DocumentPreviewPointerLocationState extends ChangeNotifier {
  PointerLocation? state;

  void update(PointerLocation? newLocation) {
    state = newLocation;
    notifyListeners();
  }
}

class PointerLocation {
  final int pageNumber;
  final double x;
  final double y;

  PointerLocation({required this.pageNumber, required this.x, required this.y});
}
