import 'package:flutter/material.dart';
import 'package:frappe_project/welcome.dart';
import 'Login.dart';

void main() async {


  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home:Login(),
    );
  }
}
