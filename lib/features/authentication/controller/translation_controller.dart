import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  void changeLanguage(var lang1, var lang2) {
    var locale = Locale(lang1, lang2);
    Get.updateLocale(locale);
  }

  // RxString langValue = 'English'.obs;
  RxString langValue = "ትግርኛ".obs;
}
