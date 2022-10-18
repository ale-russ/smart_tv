import 'package:flutter/material.dart';
import 'package:smart_tv/features/common/theme/app_themes.dart';

import '../themes.dart';

InputDecorationTheme get darkInputDecorationTheme => InputDecorationTheme(
      border: getOutlinedBorder(),
      disabledBorder: getOutlinedBorder(borderColor: Colors.white38),
      focusedBorder:
          getOutlinedBorder(borderColor: PrimaryColorTones.mainColor),
      errorBorder: getOutlinedBorder(borderColor: DarkModeColors.errorColor),
      labelStyle: const TextStyle(color: DarkModeColors.onBackgroundLightColor),
      hintStyle: const TextStyle(fontSize: 14),
      filled: true,
      fillColor: DarkModeColors.surfaceColor,
      focusColor: Colors.green,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );

InputDecorationTheme get lightInputDecorationTheme => InputDecorationTheme(
      border: getOutlinedBorder(),
      disabledBorder: getOutlinedBorder(borderColor: Colors.black26),
      focusedBorder:
          getOutlinedBorder(borderColor: PrimaryColorTones.mainColor),
      labelStyle: const TextStyle(color: Colors.black54),
      hintStyle: const TextStyle(fontSize: 14),
      filled: true,
      fillColor: LightModeColors.surfaceColor,
    );

InputDecorationTheme get searchDelegateDarkInputDecorationTheme =>
    InputDecorationTheme(
      hintStyle:
          AppThemes.dark.textTheme.bodyText2!.copyWith(color: Colors.grey),
      border: getOutlinedBorder(),
      focusedBorder:
          getOutlinedBorder(borderColor: PrimaryColorTones.mainColor),
      filled: true,
      fillColor: DarkModeColors.surfaceColor,
      contentPadding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      constraints: const BoxConstraints(maxHeight: 48),
    );

InputDecorationTheme get searchDelegateLightInputDecorationTheme =>
    InputDecorationTheme(
      hintStyle:
          AppThemes.light.textTheme.bodyText2!.copyWith(color: Colors.grey),
      border: getOutlinedBorder(),
      focusedBorder:
          getOutlinedBorder(borderColor: PrimaryColorTones.mainColor),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      constraints: const BoxConstraints(maxHeight: 48),
    );

OutlineInputBorder getOutlinedBorder({Color? borderColor}) =>
    OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: borderColor ?? Colors.grey),
    );
