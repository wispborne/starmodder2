import 'package:collection/collection.dart';
import 'package:dart_extensions_methods/dart_extension_methods.dart';
import 'package:starmodder2/models/modInfo.dart';
import 'package:starmodder2/utils.dart';
import 'package:stringr/stringr.dart';
import 'package:text_search/text_search.dart';

import 'models/modRepo.dart';

String createSearchIndex(ModInfo modInfo) =>
    "${modInfo.name} ${modInfo.authorsList?.join()} ${modInfo.categories?.join()} ${modInfo.sources?.join()}";

/// Creates a list of tags to be used for searching. All tags are lowercased.
List<TextSearchItemTerm> createSearchTags(ModInfo modInfo) {
  final alphaName = modInfo.name?.slugify();
  final tags = [
    modInfo.name?.let((it) => (term: it, penalty: 0.0)),
    alphaName?.let((it) => (term: it, penalty: 10.0)),
    ...?alphaName?.split("-").map((it) => (term: it, penalty: 10.0)),
    // Create acryonym.
    ((alphaName?.split("-").length ?? 0) > 0)
        ? alphaName!
            .split("-")
            .where((element) => element.isNotEmpty)
            .map((e) => e.substring(0, 1))
            .join()
            .let((it) => (term: it, penalty: 0.0))
        : null,
    ...?modInfo.authorsList?.map((it) => (term: it, penalty: 0.0)),
    ...?modInfo.categories?.map((it) => (term: it, penalty: 0.0)),
    modInfo.gameVersionReq?.let((it) => (term: it, penalty: 0.0)),
    // Sources (Forum, Discord)
    ...?modInfo.urls?.keys.map((it) => (term: it, penalty: 0.0)),
    ...?modInfo.sources
        ?.map((it) => modSourcesByJsonKey[it]?.displayName)
        .whereType<String>()
        .map((it) => (term: it, penalty: 0.0)),
  ]
      .filter((it) => it?.term != null && it!.term.isNotEmpty)
      .distinctBy((it) => it)
      .map((it) => TextSearchItemTerm(it!.term, it.penalty))
      .toList(growable: false);
  // Fimber.v(tags.join("\n"));
  return tags;
}

List<ModInfo>? searchMods(ModRepo? modRepo, String? query) {
  var modSearch =
      modRepo == null ? null : TextSearch(modRepo.items.map((mod) => TextSearchItem(mod, mod.searchTags)).toList());
  return (query == null || query.isEmpty || modRepo == null)
      ? modRepo?.items
      : query
          .split(",")
          .map((it) => it.trim())
          .filter((it) => it.isNotNullOrEmpty())
          .map((queryPart) => (query: queryPart, result: modSearch!.search(queryPart)))
          .filter((e) => e.result.any((element) => element.score > 0))
          .toList()
          .let((results) {
          var positiveQueryResult = results
              .filter((queryObj) => !queryObj.query.startsWith("-"))
              .map((e) => e.result)
              .flattened
              .sortedBy<num>((e) => e.score)
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
}
