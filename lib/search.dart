import 'package:starmodder2/models/modInfo.dart';
import 'package:starmodder2/utils.dart';
import 'package:stringr/stringr.dart';

String createSearchIndex(ModInfo modInfo) =>
    "${modInfo.name} ${modInfo.authorsList?.join()} ${modInfo.categories?.join()} ${modInfo.sources?.join()}";

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
    ...?modInfo.sources?.map((e) => modSourcesByJsonKey[e]?.displayName).whereType<String>()
  ].whereType<String>().map((e) => e.toLowerCase()).toList();
  // Fimber.v(tags.join("\n"));
  return tags;
}
