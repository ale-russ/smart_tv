import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes.dart';

ElevatedButtonThemeData get elevatedButtonThemeData => ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.workSans().fontFamily,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );

TextButtonThemeData get textButtonThemeData => TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: PrimaryColorTones.mainColor,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    );

OutlinedButtonThemeData get outlinedButtonThemeData => OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: PrimaryColorTones.mainColor,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    );

FloatingActionButtonThemeData get darkFloatingActionButtonTheme =>
    const FloatingActionButtonThemeData(
      backgroundColor: PrimaryColorTones.mainColor,
      foregroundColor: DarkModeColors.onPrimaryColor,
    );

FloatingActionButtonThemeData get lightFloatingActionButtonTheme =>
    const FloatingActionButtonThemeData(
      backgroundColor: PrimaryColorTones.mainColor,
      foregroundColor: LightModeColors.onPrimaryColor,
    );
