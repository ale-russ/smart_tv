import 'package:flutter/material.dart';
import 'package:smart_tv/features/common/theme/theme_data/button_theme.dart';
import 'package:smart_tv/features/common/theme/theme_data/card_theme.dart';
import 'package:smart_tv/features/common/theme/theme_data/input_decoration_theme.dart';
import 'package:smart_tv/features/common/theme/theme_data/text_theme.dart';
import 'package:smart_tv/features/common/theme/themes.dart';

class AppThemes {
  static ThemeData get dark => ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        colorScheme: darkColorScheme,
        splashColor: PrimaryColorTones.mainColor.withOpacity(0.2),
        highlightColor: DarkModeColors.onBackgroundColor.withOpacity(0.36),
        shadowColor: const Color(0X28FFFFFF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        tabBarTheme: const TabBarTheme(
          labelColor: DarkModeColors.onBackgroundColor,
          unselectedLabelColor: DarkModeColors.onBackgroundLightColor,
        ),
        inputDecorationTheme: darkInputDecorationTheme,
        textTheme: darkTextTheme,
        cardColor: DarkModeColors.backgroundVariant,
        cardTheme: darkCardTheme,
        iconTheme: IconThemeData(color: DarkModeColors.onBackgroundLightColor),
        focusColor: PrimaryColorTones.mainColor,
        scaffoldBackgroundColor: DarkModeColors.backgroundColor,
        dividerColor: Colors.white60,
        backgroundColor: DarkModeColors.backgroundColor,
      );

  static ThemeData get light => ThemeData.light().copyWith(
        primaryColor: Colors.white,
        colorScheme: lightColorScheme,
        cardColor: LightModeColors.surfaceColor,
        splashColor: PrimaryColorTones.mainColor.withOpacity(0.8),
        highlightColor: LightModeColors.surfaceColor.withOpacity(0.8),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: elevatedButtonThemeData,
        textButtonTheme: textButtonThemeData,
        outlinedButtonTheme: outlinedButtonThemeData,
        checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.resolveWith((states) {
          if (!states.contains(MaterialState.selected)) return Colors.grey;
          return PrimaryColorTones.mainColor;
        })),
        inputDecorationTheme: lightInputDecorationTheme,
        textTheme: lightTextTheme,
        cardTheme: lightCardTheme,
        iconTheme: IconThemeData(color: LightModeColors.onBackgroundColor),
        backgroundColor: LightModeColors.backgroundColor,
        scaffoldBackgroundColor: LightModeColors.backgroundColor,
        dividerColor: Colors.black54,
        brightness: Brightness.light,
      );

  //     static ThemeData get searchDelegateDarkAppBar => dark.copyWith(
  //       appBarTheme: darkSearchDelegateAppBar,
  //       inputDecorationTheme: searchDelegateDarkInputDecorationTheme,
  //     );

  // static ThemeData get searchDelegateLightAppBar => light.copyWith(
  //       primaryColor: PrimaryColorTones.mainColor,
  //       appBarTheme: lightSearchDelegateAppBar,
  //       inputDecorationTheme: searchDelegateLightInputDecorationTheme,
  //     );
}
