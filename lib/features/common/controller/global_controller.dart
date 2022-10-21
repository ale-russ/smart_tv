import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_tv/features/authentication/view/login_page.dart';
import 'package:smart_tv/features/common/services/dbAccess.dart';

import '../../../config/intentFiles/button_intents.dart';

class GlobalController extends GetxController {
  BuildContext? globalContext;

  String defaultLanguage = "English";
  RxBool initialised = false.obs;
  RxBool data = false.obs;

  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'profile',
    ],
  );

  GoogleSignInAccount? user;

  Map<ShortcutActivator, Intent> navigationIntents = {
    LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
    LogicalKeySet(LogicalKeyboardKey.arrowRight): RightbuttonIntent(),
    LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftbuttonIntent(),
    LogicalKeySet(LogicalKeyboardKey.arrowUp): UpbuttonIntent(),
    LogicalKeySet(LogicalKeyboardKey.arrowDown): DownbuttonIntent(),
    LogicalKeySet(LogicalKeyboardKey.goBack): BackButtonIntent()
    //LogicalKeySet(LogicalKeyboardKey.back)
  };

  Locale? _locale;

  Locale get appLocale => _locale ?? const Locale('en', 'US');

  Future setAppLanguage({String? selectedLanguage}) async {
    defaultLanguage =
        selectedLanguage ?? DbAccess.readData('lang', defaultValue: "English");

    switch (defaultLanguage) {
      case 'English':
        _locale = const Locale('en', 'US');
        break;

      case 'tigrinya':
        _locale = const Locale('ti', 'ER');
    }
  }

  Future logOutUser({BuildContext? context}) async {
    Navigator.pushReplacement(
        context!, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
