
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:shared_preferences/shared_preferences.dart';


class ThemeController extends GetxController{
  @override
  void onInit() {
    loadThemeFromPreferences();
  }

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
    secondaryHeaderColor: Colors.white

  );


  ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
    primaryColor: Colors.grey[600],
    secondaryHeaderColor: Colors.grey[600]

  );

  var isDarkMode=false.obs;

  void changeTheme() {
    isDarkMode.value = !isDarkMode.value;
    if (isDarkMode.value) {
      Get.changeTheme(darkTheme);
    } else {
      Get.changeTheme(lightTheme);
    }
    saveThemeToPreferences();
  }

  void saveThemeToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode.value);
  }

  void loadThemeFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    if (isDarkMode.value) {
      Get.changeTheme(darkTheme);
    } else {
      Get.changeTheme(lightTheme);
    }
  }
}
