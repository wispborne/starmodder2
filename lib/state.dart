import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'models/modRepo.dart';

final allMods = StateProvider<ModRepo?>((ref) => null);
final locale = StateProvider<String?>((ref) => Intl.defaultLocale);

final search = StateProvider<String?>((ref) => null);