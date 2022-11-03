import 'package:flutter/material.dart';

var darkTheme = ThemeData(brightness: Brightness.dark);

class Themes {
  static final basic =
      ThemeData.dark(useMaterial3: true).copyWith(brightness: Brightness.dark, primaryColor: Colors.cyan, accentColor: Colors.cyanAccent);

  static final starsectorLauncher = darkTheme.copyWith(
      colorScheme: darkTheme.colorScheme.copyWith(
          primary: const Color.fromRGBO(73, 252, 255, 1),
          secondary: const Color.fromRGBO(59, 203, 232, 1),
          tertiary: const Color.fromRGBO(0, 255, 255, 1)),
      scaffoldBackgroundColor: const Color.fromRGBO(14, 22, 43, 1),
      dialogBackgroundColor: const Color.fromRGBO(14, 22, 43, 1));
}
