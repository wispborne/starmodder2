import 'package:collection/collection.dart';
import 'package:dart_extensions_methods/dart_extension_methods.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starmodder2/models/modInfo.dart';
import 'package:text_search/text_search.dart';

import 'models/modRepo.dart';

part 'generated/state.g.dart';

// @riverpod
// ModRepo? allMods(AllModsRef ref) => null;
final allMods = StateProvider<ModRepo?>((ref) => null);
final locale = StateProvider<String?>((ref) => Intl.defaultLocale);

final search = StateProvider<String?>((ref) => null);

@riverpod
List<ModInfo>? searchResults(SearchResultsRef ref) {
  final modRepo = ref.watch(allMods);
  final query = ref.watch(search)?.toLowerCase();
  var modSearch = modRepo == null
      ? null
      : TextSearch(modRepo.items
          .map((mod) => TextSearchItem(mod, mod.searchTags.map((tag) => TextSearchItemTerm(tag))))
          .toList());
  final mods = (query == null || query.isEmpty || modRepo == null)
      ? modRepo?.items
      : query
          .split(",")
          .map((it) => it.trim())
          .filter((it) => it.isNotNullOrEmpty())
          .map((queryPart) => (query: queryPart, result: modSearch!.search(queryPart)))
          .toList()
          .let((results) {
          var positiveQueryResult = results
              .filter((queryObj) => !queryObj.query.startsWith("-"))
              .map((e) => e.result)
              .flattened
              .map((e) => e.object);
          var negativeQueryResult = results
              .filter((queryObj) => queryObj.query.startsWith("-"))
              .map((e) => e.result)
              .flattened
              .map((e) => e.object);
          if (positiveQueryResult.isEmpty) {
            return modRepo.items.filter((mod) => !negativeQueryResult.contains(mod));
          } else {
            return positiveQueryResult.filter((mod) => !negativeQueryResult.contains(mod));
          }
        }).toList();
  return mods;
}

final modsVisibleCount = StateProvider<int?>((ref) => null);
