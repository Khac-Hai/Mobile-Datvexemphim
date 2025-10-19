import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTheme {
  static ThemeData light() {
    final base = ThemeData.dark();
    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFF0F1724),
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
      colorScheme: base.colorScheme.copyWith(
        primary: const Color(0xFFF6C85F),
        secondary: const Color(0xFF7C88A0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
      ),
    );
  }
}