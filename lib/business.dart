import 'dart:convert';

import 'package:fimber/fimber.dart';
import 'package:http/http.dart' as http;
import 'package:starmodder2/logging.dart';
import 'package:starmodder2/models/modRepo.dart';

Future<ModRepo?> fetchAndParseModInfo(Iterable<String> args) async {
  initLogging();
  Fimber.i("Fetching mods...");
  final url = Uri.parse(
      "https://raw.githubusercontent.com/wispborne/StarsectorModRepo/main/ModRepo.json");
  try {
    final response = await http.get(url);
    var modRepo = ModRepo.fromJson(jsonDecode(response.body));
    Fimber.i("Fetched ${modRepo.totalCount} mods.");
    Fimber.d(modRepo.toString());
    return modRepo;
  } catch (e, stacktrace) {
    Fimber.e("Failed to get stuff.", ex: e, stacktrace: stacktrace);
  }
  return null;
}
