import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildTheme(Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: const Color.fromARGB(255, 29, 74, 128),
    ),
    textTheme: GoogleFonts.latoTextTheme().apply(
      bodyColor: brightness == Brightness.dark ? Colors.white : Colors.black,
      displayColor: brightness == Brightness.dark ? Colors.white : Colors.black,
    ),
  );
}
