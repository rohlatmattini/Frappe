import 'dart:ui';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../main.dart';

class MyLocaleController extends GetxController {
  Rx<Locale> currentLocale = Rx<Locale>(Locale('en'));


  Locale initialLocale = sharedpref!.getString("lang") == "ar" ? Locale("ar") : Locale("en");


  void changeLang(String languageCode) {
    Locale locale = Locale(languageCode);
    sharedpref!.setString("lang", languageCode);
    Get.updateLocale(locale);
  }
}
