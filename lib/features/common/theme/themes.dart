import 'package:flutter/material.dart';

class PrimaryColorTones {
  static const mainColor = Color(0xFFFFA500);
  static const tone50 = Color(0xFFFFF3DE);
  static const tone100 = Color(0xffffe0ae);
  static const tone200 = Color(0xffffcb78);
  static const tone300 = Color(0xffffb640);
  static const tone400 = Color(0xffffa600);
  static const tone500 = Color(0xffff9600);
  static const tone600 = Color(0xfffc8a00);
  static const tone700 = Color(0xfff77900);
  static const tone800 = Color(0xfff26800);
  static const tone900 = Color(0xffe94b00);
}

class DarkModeColors {
  static const onPrimaryColor = Colors.black87;
  static const surfaceColor = Color(0xFF2b2b2b);
  static final onSurfaceColor = Colors.white.withOpacity(0.87);
  static const backgroundColor = Color(0xFF121212);
  static const backgroundVariant = Color(0xFF1F1F1F);
  static const onBackgroundColor = Color(0xDDFFFFFF);

  static const onBackgroundLightColor = Color(0x99FFFFFF);
  static const borderColor = Colors.white24;
  static const errorColor = Color(0xFFFF0000);
}

class LightModeColors {
  static const onPrimaryColor = Colors.black87;
  static const surfaceColor = Colors.white;
  static const onSurfaceColor = Colors.black87;
  static final backgroundColor = Colors.grey.shade200;
  static final backgroundVariant = Colors.grey.shade100;
  static const onBackgroundColor = Colors.black87;
  static final onBackgroundLightColor = Colors.black.withOpacity(0.60);
  static const borderColor = Colors.black26;
  static const errorColor = Color(0xFFB00020);
}

// for avatars without picture
List<Color> avatarColors = [
  const Color(0xFF00AA55),
  const Color(0xFF009FD4),
  const Color(0xFFB381B3),
  const Color(0xFF939393),
  const Color(0xFFE3BC00),
  const Color(0xFFD47500),
  const Color(0xFFDC2A2A),
];

ColorScheme get darkColorScheme => ColorScheme(
      primary: PrimaryColorTones.mainColor,
      onPrimary: DarkModeColors.onPrimaryColor,
      secondaryContainer: DarkModeColors.backgroundVariant,
      background: DarkModeColors.backgroundColor,
      onBackground: DarkModeColors.onBackgroundColor,
      brightness: Brightness.dark,
      error: DarkModeColors.errorColor,
      onError: DarkModeColors.onBackgroundLightColor,
      secondary: DarkModeColors.backgroundVariant,
      onSecondary: DarkModeColors.onBackgroundColor,
      surface: DarkModeColors.surfaceColor,
      onSurface: DarkModeColors.onSurfaceColor,
    );

ColorScheme get lightColorScheme => ColorScheme(
      primary: PrimaryColorTones.mainColor,
      secondaryContainer: PrimaryColorTones.tone50,
      background: LightModeColors.backgroundColor,
      onBackground: LightModeColors.onBackgroundColor,
      brightness: Brightness.light,
      error: LightModeColors.errorColor,
      onError: LightModeColors.onBackgroundLightColor,
      onPrimary: LightModeColors.onPrimaryColor,
      secondary: LightModeColors.backgroundVariant,
      onSecondary: LightModeColors.onBackgroundColor,
      surface: LightModeColors.surfaceColor,
      onSurface: LightModeColors.onSurfaceColor,
    );
