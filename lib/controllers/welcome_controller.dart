import 'package:get/get.dart';
import 'package:flutter/material.dart';

class WelcomeController extends GetxController {
  var selectedLang = 'en'.obs;

  void changeLanguage(String langCode) {
    selectedLang.value = langCode;
    Get.updateLocale(Locale(langCode));
  }
}
