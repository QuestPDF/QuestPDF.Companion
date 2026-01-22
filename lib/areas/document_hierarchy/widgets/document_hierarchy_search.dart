import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/font_awesome_icons.dart';
import '../state/document_hierarchy_search_state.dart';

class DocumentHierarchySearch extends ConsumerStatefulWidget {
  const DocumentHierarchySearch({super.key});

  @override
  _DocumentHierarchySearchState createState() => _DocumentHierarchySearchState();
}

class _DocumentHierarchySearchState extends ConsumerState<DocumentHierarchySearch> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = ref.watch(documentHierarchySearchStateProvider);

    return Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        margin: EdgeInsets.only(top: 12),
        child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 4, right: 4, bottom: 4),
            child: buildPositionCardHeader(Theme.of(context), searchProvider)));
  }

  Widget buildPositionCardHeader(ThemeData theme, DocumentHierarchySearchState searchState) {
    final textColor = theme.colorScheme.onPrimaryContainer;
    final disabledTextColor = theme.colorScheme.onPrimaryContainer.withAlpha(128);

    final searchFieldStyle = theme.textTheme.bodyMedium?.copyWith(color: textColor);
    final headerStyle = theme.textTheme.bodyMedium?.copyWith(color: textColor);
    final enablePositionButtons = searchState.searchResults.isNotEmpty;

    return Row(children: [
      Flexible(
          child: TextField(
        focusNode: _focusNode,
        style: searchFieldStyle,
        decoration: InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: const EdgeInsets.all(0),
            hintText: "Search Phrase",
            hintStyle: TextStyle(color: textColor.withAlpha(128))),
        onChanged: (x) => Future.microtask(() => searchState.update(x)),
      )),
      const SizedBox(width: 32),
      if (searchState.showSearchCount)
        Text("${searchState.searchResultIndex + 1} / ${searchState.searchResults.length}", style: headerStyle),
      if (searchState.showSearchCount) const SizedBox(width: 8),
      IconButton(
          icon: Icon(FontAwesomeIcons.arrowUp, color: enablePositionButtons ? textColor : disabledTextColor, size: 16),
          visualDensity: VisualDensity.compact,
          disabledColor: Colors.red,
          onPressed: enablePositionButtons ? () => searchState.changeCurrentSearchIndex(-1) : null),
      IconButton(
        icon: Icon(FontAwesomeIcons.arrowDown, color: enablePositionButtons ? textColor : disabledTextColor, size: 16),
        visualDensity: VisualDensity.compact,
        onPressed: enablePositionButtons ? () => searchState.changeCurrentSearchIndex(1) : null,
      ),
      IconButton(
          icon: Icon(FontAwesomeIcons.close, color: textColor, size: 16),
          visualDensity: VisualDensity.compact,
          onPressed: searchState.reset)
    ]);
  }
}
