import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questpdf_companion/areas/generic_exception/generic_exception_view_state_provider.dart';
import 'package:questpdf_companion/areas/generic_exception/widgets/generic_exception_view_item.dart';

import '../models/generic_exception_details.dart';

class GenericExceptionViewLayout extends ConsumerWidget {
  const GenericExceptionViewLayout({super.key});

  static List<GenericExceptionDetails> flatten(GenericExceptionDetails? exception) {
    List<GenericExceptionDetails> result = [];

    while (exception != null) {
      result.add(exception);
      exception = exception.innerException;
    }

    return result;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exception = ref.watch(genericExceptionViewStateProvider).state;

    final exceptionWidgets = flatten(exception)
        .map((x) => [
              const SizedBox(height: 16),
              GenericExceptionViewItem(type: x.type, message: x.message, stackTrace: x.stackTrace)
            ])
        .expand((x) => x)
        .toList();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
                margin: const EdgeInsets.all(16),
                constraints: const BoxConstraints(maxWidth: 700),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: exceptionWidgets,
                )),
          ),
        ),
      ),
    );
  }
}
