import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questpdf_companion/areas/generic_exception/models/generic_exception_details.dart';
import 'package:questpdf_companion/areas/generic_exception/models/show_generic_exception_command.dart';

final genericExceptionViewStateInstance = GenericExceptionViewState();
final genericExceptionViewStateProvider = ChangeNotifierProvider((ref) => genericExceptionViewStateInstance);

class GenericExceptionViewState extends ChangeNotifier {
  GenericExceptionDetails? state;

  void setException(ShowGenericExceptionCommand? command) {
    state = command?.exception;
    notifyListeners();
  }
}
