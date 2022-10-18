import 'package:flutter/material.dart';
import '../themes.dart';

CardTheme get darkCardTheme => cardTheme.copyWith(
      elevation: 3,
      color: DarkModeColors.backgroundVariant,
      shadowColor: Colors.transparent,
    );

CardTheme get lightCardTheme => cardTheme.copyWith(
      elevation: 2,
      color: LightModeColors.surfaceColor,
      shadowColor: LightModeColors.backgroundColor,
    );

CardTheme get cardTheme => const CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
