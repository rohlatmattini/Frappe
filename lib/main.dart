import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frappe_project/Project.dart';
import 'package:frappe_project/homepage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Locale/Locale.dart';
import 'Locale/LocaleController.dart';
import 'Login.dart';
import 'Theme/themeController.dart';

SharedPreferences? sharedpref;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedpref = await SharedPreferences.getInstance();

  Get.put(ThemeController());

  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ThemeController themeController = Get.find();
  MyLocaleController controller = Get.put(MyLocaleController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      title: 'Flutter Demo',
      theme: themeController.lightTheme,
      darkTheme: themeController.darkTheme,
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,

      locale: controller.initialLocale,
      translations: MyLocale(),

      home: SplashScreen(),
      routes: {
        '/login':(context) => Login(),
        '/home': (context) => Homepage(),
      },
    ));

  }
}

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }
  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? email = pref.getString("email");
    String? password = pref.getString("password");

    if (email != null && password != null && password.isNotEmpty) {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      var request = http.Request(
        'POST', Uri.parse('https://erp.darmesk.consulting/api/method/login'),
      );
      request.body = json.encode({
        "usr": email,
        "pwd": password,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        pref.remove('email');
        pref.remove('password');
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: CircularProgressIndicator(),));
  }
}

