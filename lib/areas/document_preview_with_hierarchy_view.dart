import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:questpdf_companion/areas/document_hierarchy/state/document_hierarchy_search_state.dart';

import 'application/state/application_state_provider.dart';
import 'document_hierarchy/widgets/document_hierarchy_layout.dart';
import 'document_preview/widgets/document_preview_layout.dart';

class DocumentPreviewWithHierarchyView extends ConsumerWidget {
  static final documentPreviewKey = GlobalKey();
  static final documentHierarchyKey = GlobalKey();

  const DocumentPreviewWithHierarchyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showDocumentHierarchy = ref.watch(applicationStateProvider.select((x) => x.showDocumentHierarchy));
    final isSearchActive = ref.watch(documentHierarchySearchStateProvider.select((x) => x.searchPhrase != null));

    if (!showDocumentHierarchy && !isSearchActive) {
      return DocumentPreviewLayout(key: documentPreviewKey);
    }

    return MultiSplitView(
      key: documentHierarchyKey,
      initialAreas: [
        Area(
          size: 300,
          min: 250,
          max: 500,
          builder: (context, area) => const DocumentHierarchyLayout(),
        ),
        Area(
          builder: (context, area) => DocumentPreviewLayout(key: documentPreviewKey),
        )
      ],
    );
  }
}
