import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frappe_project/Login.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class Welcome extends StatefulWidget {

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isRememberme=false;
  bool _isLoading = false;
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    loadUserInfo();
  }

  void loadUserInfo()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      emailController.text =(preferences.getString("email")?? "");
      passwordController.text =(preferences.getString("password")?? "");
      isRememberme =(preferences.getBool("isRemeberme")?? false);




    });
    if(isRememberme&&emailController.text.isNotEmpty&&passwordController.text.isNotEmpty){
      postData();
    }
  }




  void postData() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var request = http.Request(
      'POST',
      Uri.parse('https://erp.darmesk.consulting/api/method/login'),
    );
    request.body = json.encode({
      "usr": emailController.text,
      "pwd": passwordController.text,
    });
    request.headers.addAll(headers);

    try {

      _timer = Timer(Duration(seconds: 20), () {
        if (_isLoading) {
          print('Request timed out, resending...');
          postData();
        }
      });

      http.StreamedResponse response = await request.send();

      _timer?.cancel();

      if (response.statusCode == 200) {
        String info = await response.stream.bytesToString();
        print('Login successful: $info');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      } else {
        _handleErrorResponse(response.statusCode);
      }
    } on SocketException catch (_) {
      _handleNetworkError();
    } catch (e) {
      print('An error occurred: $e');
      _showSnackBar("An error occurred: $e");
    } finally {
      setState(() {
        _isLoading = false; // Set loading state back to false
      });
    }
  }
  void _handleErrorResponse(int statusCode) {
    print('Login failed with status code: $statusCode');
    if (statusCode == 503) {
      _showSnackBar("Check your internet connection");
    } else if (statusCode == 408) {
      _showSnackBar("Request Timeout. Please try again.");
    } else {
      _showSnackBar("Your Password or Email is incorrect");
    }
  }

  void _handleNetworkError() {
    print('No internet connection');
    _showSnackBar("No internet connection. Please check your network.");
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black45,
      content: Text(message),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:Image(image:AssetImage("images/welcome.jpg"),fit:BoxFit.fill,),
          ),
          Center(child: Text("Welcome To Our App",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
          Padding(
            padding: const EdgeInsets.only(top:500 ),
            child: MaterialButton(
              height: 45,
              minWidth: 300,
              shape: OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login()));
              },
              child:  Text("Let's start ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
