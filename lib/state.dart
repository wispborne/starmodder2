import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starmodder2/models/modInfo.dart';
import 'package:starmodder2/search.dart';

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
  final mods = searchMods(modRepo, query);
  return mods;
}

final modsVisibleCount = StateProvider<int?>((ref) => null);
