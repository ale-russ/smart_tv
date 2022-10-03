import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controller/global_controller.dart';

import 'colors_utility.dart';

class KabbeeIcons {
  // asset paths of all custom icons
  static String iconFolder = 'assets/icons';
  static String homeAsset = '$iconFolder/home.svg';
  static String homeFilledAsset = '$iconFolder/home_filled.svg';
  static String commingSoonAsset = '$iconFolder/coming_soon.svg';
  static String commingSoonFilledAsset = '$iconFolder/coming_soon_filled.svg';
  static String searchAsset = '$iconFolder/search.svg';
  static String searchFilledAsset = '$iconFolder/search_filled.svg';
  static String libraryAsset = '$iconFolder/library.svg';
  static String libraryFilledAsset = '$iconFolder/library_filled.svg';
  static String profileAsset = '$iconFolder/profile.svg';
  static String profileFilledAsset = '$iconFolder/profile_filled.svg';
  static String userRoleAsset = '$iconFolder/user_role_filled.svg';

  static String lightThemeAsset = '$iconFolder/light_theme_filled.svg';
  static String darkThemeAsset = '$iconFolder/dark_theme_filled.svg';

  static String starAsset = '$iconFolder/star_filled.svg';
  static String helpAsset = '$iconFolder/help_filled.svg';
  static String webAsset = '$iconFolder/web_filled.svg';
  static String calendarAsset = '$iconFolder/calendar.svg';
  static String calendarFilledAsset = '$iconFolder/calendar_filled.svg';
  static String genderAsset = '$iconFolder/gender_filled.svg';
  static String mailAsset = '$iconFolder/mail_filled.svg';
  static String lockAsset = '$iconFolder/lock_filled.svg';
  static String openLockAsset = '$iconFolder/lock_open_filled.svg';
  static String shareAsset = '$iconFolder/share_filled.svg';
  static String addItemAsset = '$iconFolder/add_item_filled.svg';
  static String playAsset = '$iconFolder/play.svg';
  static String editImageAsset = '$iconFolder/edit_image_filled.svg';
  static String editpasswordAsset = '$iconFolder/edit_password_filled.svg';
  static String subscriptionAsset = '$iconFolder/subscription_filled.svg';
  static String activeAsset = '$iconFolder/active_filled.svg';
  static String incompleteAsset = '$iconFolder/incomplete_filled.svg';
  static String pendingAsset = '$iconFolder/pending_filled.svg';
  static String receiptAsset = '$iconFolder/receipt_filled.svg';
  static String referralAsset = '$iconFolder/referral_filled.svg';

  static String infoAsset = '$iconFolder/info_filled.svg';
  static String privacyAsset = '$iconFolder/privacy_filled.svg';
  static String warningAsset = '$iconFolder/warning_filled.svg';
  static String logOutAsset = '$iconFolder/log_out_filled.svg';
  static String campaignAsset = '$iconFolder/campaign_filled.svg';

  static String placeholderAsset = '$iconFolder/placeholder.svg';

  static Widget home({Color? color, double? size}) =>
      fromAsset(homeAsset, color, size);

  static Widget homeFilled({Color? color, double? size}) =>
      fromAsset(homeFilledAsset, color, size);

  static Widget comingSoon({Color? color, double? size}) =>
      fromAsset(commingSoonAsset, color, size);

  static Widget comingSoonFilled({Color? color, double? size}) =>
      fromAsset(commingSoonFilledAsset, color, size);

  static Widget search({Color? color, double? size}) =>
      fromAsset(searchAsset, color, size);

  static Widget searchFilled({Color? color, double? size}) =>
      fromAsset(searchFilledAsset, color, size);

  static Widget library({Color? color, double? size}) =>
      fromAsset(libraryAsset, color, size);

  static Widget libraryFilled({Color? color, double? size}) =>
      fromAsset(libraryFilledAsset, color, size);

  static Widget profile({Color? color, double? size}) =>
      fromAsset(profileAsset, color, size);

  static Widget profileFilled({Color? color, double? size}) =>
      fromAsset(profileFilledAsset, color, size);

  static Widget userRoleFilled({Color? color, double? size}) =>
      fromAsset(userRoleAsset, color, size);

  static Widget star({Color? color, double? size}) =>
      fromAsset(starAsset, color, size);

  static Widget help({Color? color, double? size}) =>
      fromAsset(helpAsset, color, size);

  static Widget web({Color? color, double? size}) =>
      fromAsset(webAsset, color, size);

  static Widget calendar({Color? color, double? size}) =>
      fromAsset(calendarAsset, color, size);

  static Widget calendarFilled({Color? color, double? size}) =>
      fromAsset(calendarFilledAsset, color, size);

  static Widget gender({Color? color, double? size}) =>
      fromAsset(genderAsset, color, size);

  static Widget mail({Color? color, double? size}) =>
      fromAsset(mailAsset, color, size);

  static Widget lock({Color? color, double? size}) =>
      fromAsset(lockAsset, color, size);

  static Widget unlock({Color? color, double? size}) =>
      fromAsset(openLockAsset, color, size);

  static Widget share({Color? color, double? size}) =>
      fromAsset(shareAsset, color, size);

  static Widget addItem({Color? color, double? size}) =>
      fromAsset(addItemAsset, color, size);

  static Widget play({Color? color, double? size}) =>
      fromAsset(playAsset, color, size);

  static Widget editImage({Color? color, double? size}) =>
      fromAsset(editImageAsset, color, size);

  static Widget campaign({Color? color, double? size}) =>
      fromAsset(campaignAsset, color, size);

  static Widget lightTheme({Color? color, double? size}) =>
      fromAsset(lightThemeAsset, color, size);

  static Widget darkTheme({Color? color, double? size}) =>
      fromAsset(darkThemeAsset, color, size);

  static Widget active({Color? color, double? size}) =>
      fromAsset(activeAsset, color, size);

  static Widget pending({Color? color, double? size}) =>
      fromAsset(pendingAsset, color, size);

  static Widget incomplete({Color? color, double? size}) =>
      fromAsset(incompleteAsset, color, size);

  /// Accepts SVG asset path, color & size
  /// and returns an SVG icon widget
  static SvgPicture fromAsset(String asset, Color? color, double? size) {
    var context = Get.find<GlobalController>().globalContext;

    color ??= context != null ? iconColor(context) : null;

    if (asset.endsWith('svg')) {
      return SvgPicture.asset(
        asset,
        height: size,
        color: color,
      );
    }
    return SvgPicture.asset(
      placeholderAsset,
      height: size,
      color: color,
    );
  }
}
