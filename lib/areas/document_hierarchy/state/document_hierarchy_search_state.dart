import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/document_hierarchy_element.dart';
import 'document_hierarchy_provider.dart';

final documentHierarchySearchStateInstance = DocumentHierarchySearchState();
final documentHierarchySearchStateProvider = ChangeNotifierProvider((ref) => documentHierarchySearchStateInstance);

class SearchCacheItem {
  String text;
  DocumentHierarchyElement element;

  SearchCacheItem(this.text, this.element);
}

class DocumentHierarchySearchState extends ChangeNotifier {
  String? searchPhrase;
  List<SearchCacheItem>? searchableElements;
  List<SearchCacheItem>? searchableElementsForCurrentPhrase;
  List<DocumentHierarchyElement> searchResults = [];
  int searchResultIndex = 0;

  bool get showSearchCount => (searchPhrase?.isNotEmpty ?? false) && searchResults.isNotEmpty;

  void reset() {
    searchPhrase = null;
    searchResultIndex = 0;
    searchResults = [];

    searchableElements = null;
    searchableElementsForCurrentPhrase = null;

    focusOnCurrentSearchResult();
    notifyListeners();
  }

  void update(String? phrase) {
    if (phrase != null && searchPhrase != null && !phrase.contains(searchPhrase!)) {
      searchableElementsForCurrentPhrase = null;
    }

    searchPhrase = phrase;
    searchResultIndex = 0;
    searchResults = [];

    search();

    focusOnCurrentSearchResult();
    notifyListeners();
  }

  List<SearchCacheItem> getSearchableElements() {
    if (documentHierarchyProviderInstance.state == null) return [];

    List<SearchCacheItem> result = [];

    final searchableElementTypes = ["TextBlock", "DebugPointer"];

    void traverse(DocumentHierarchyElement element) {
      if (searchableElementTypes.contains(element.elementType) && element.searchableContent.isNotNullOrEmpty) {
        result.add(SearchCacheItem(element.searchableContent!.toLowerCase(), element));
      }

      element.children.forEach(traverse);
    }

    traverse(documentHierarchyProviderInstance.state!);
    return result;
  }

  void search() {
    if (searchPhrase.isNullOrEmpty) return;

    final phrase = searchPhrase!.toLowerCase();
    searchableElements ??= getSearchableElements();
    searchableElementsForCurrentPhrase ??= searchableElements;

    searchableElementsForCurrentPhrase =
        searchableElementsForCurrentPhrase!.where((x) => x.text.contains(phrase)).toList();
    searchResults = searchableElementsForCurrentPhrase!.map((x) => x.element).distinct().toList();
  }

  void changeCurrentSearchIndex(int direction) {
    searchResultIndex = (searchResultIndex + direction) % max(1, searchResults.length);
    focusOnCurrentSearchResult();
    notifyListeners();
  }

  void focusOnCurrentSearchResult() {
    if (searchResults.isEmpty)
      documentHierarchyProviderInstance.setSelectedElement(null);
    else
      documentHierarchyProviderInstance.setSelectedElementAndFocusOnIt(searchResults[searchResultIndex]);
  }
}
