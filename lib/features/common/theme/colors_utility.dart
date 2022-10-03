import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/theme/themes.dart';

Color primaryColor(BuildContext context) =>
    Theme.of(context).colorScheme.primary;

Color onPrimary(BuildContext context) =>
    Theme.of(context).colorScheme.onPrimary;

Color backgroundColor(BuildContext context) =>
    Theme.of(context).colorScheme.background;

Color onBackground(BuildContext context) =>
    Theme.of(context).colorScheme.onBackground;

Color? textBodyColor(BuildContext context) =>
    Theme.of(context).textTheme.bodyText2!.color;

Color surfaceColor(BuildContext context) =>
    Theme.of(context).colorScheme.surface;

Color onSurface(BuildContext context) =>
    Theme.of(context).colorScheme.onSurface;

Color secondaryColor(BuildContext context) =>
    Theme.of(context).colorScheme.secondary;

Color errorColor(BuildContext context) => Theme.of(context).colorScheme.error;

Color onError(BuildContext context) => Theme.of(context).colorScheme.onError;

Color cardColor(BuildContext context) => Theme.of(context).cardColor;

Color? iconColor(BuildContext context) => Theme.of(context).iconTheme.color;

Color getAvatarColor(String text) {
  int charCode = text.codeUnitAt(0);
  return avatarColors[charCode % avatarColors.length];
}
