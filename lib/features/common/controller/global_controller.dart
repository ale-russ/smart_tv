import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/authentication/view/login_page.dart';
import 'package:smart_tv/features/common/services/dbAccess.dart';

class GlobalController extends GetxController {
  BuildContext? globalContext;

  String defaultLanguage = "English";

  Locale? _locale;

  Locale get appLocale => _locale ?? const Locale('en', "US");

  Future setAppLanguage({String? selectedLanguage}) async {
    defaultLanguage =
        selectedLanguage ?? DbAccess.readData('lang', defaultValue: "English");

    switch (defaultLanguage) {
      case 'English':
        _locale = const Locale('en', "US");
        break;

      case 'Tigrigna':
        _locale = const Locale('tig', "ER");
    }
  }

  Future logOutUser({BuildContext? context}) async {
    Navigator.pushReplacement(
        context!, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
