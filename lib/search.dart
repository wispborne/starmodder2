import 'package:dart_extensions_methods/dart_extension_methods.dart';
import 'package:starmodder2/models/modInfo.dart';
import 'package:starmodder2/utils.dart';
import 'package:stringr/stringr.dart';

String createSearchIndex(ModInfo modInfo) =>
    "${modInfo.name} ${modInfo.authorsList?.join()} ${modInfo.categories?.join()} ${modInfo.sources?.join()}";

/// Creates a list of tags to be used for searching. All tags are lowercased.
List<String> createSearchTags(ModInfo modInfo) {
  final alphaName = modInfo.name?.slugify();
  final tags = [
    modInfo.name,
    alphaName,
    ...?alphaName?.split("-"),
    ((alphaName?.split("-").length ?? 0) > 0)
        ? alphaName!.split("-").where((element) => element.isNotEmpty).map((e) => e.substring(0, 1)).join()
        : null,
    ...?modInfo.authorsList,
    ...?modInfo.categories,
    modInfo.gameVersionReq,
    ...?modInfo.urls?.keys,
    ...?modInfo.sources?.map((e) => modSourcesByJsonKey[e]?.displayName).whereType<String>()
  ]
      .whereType<String>()
      .map((e) => e.toLowerCase())
      .distinctBy((e) => e)
      .filter((element) => element.isNotEmpty)
      .toList(growable: false);
  // Fimber.v(tags.join("\n"));
  return tags;
}
