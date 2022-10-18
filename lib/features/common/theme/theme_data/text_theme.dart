import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_tv/features/common/theme/themes.dart';

TextTheme get textTheme => GoogleFonts.workSansTextTheme().copyWith(
      headline1: const TextStyle(fontSize: 48),
      headline2: const TextStyle(fontSize: 34),
      headline3: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      headline4: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyText1: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      bodyText2: const TextStyle(fontSize: 17).apply(
        fontFamily: GoogleFonts.workSans().fontFamily,
      ),
    );

TextTheme get darkTextTheme => textTheme.apply(
      displayColor: DarkModeColors.onBackgroundColor,
      bodyColor: LightModeColors.onBackgroundColor,
      decorationColor: LightModeColors.onBackgroundColor,
    );

TextTheme get lightTextTheme => textTheme.apply(
      displayColor: LightModeColors.onBackgroundColor,
      bodyColor: LightModeColors.onBackgroundColor,
      decorationColor: LightModeColors.onBackgroundColor,
    );
