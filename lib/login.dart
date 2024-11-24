import 'dart:async'; // Import Timer class
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  Timer? _timer;
  bool isRememberme=false;
    void _handleRememberMe(bool value) {
    setState(() {
      isRememberme = value;
    });

    if (isRememberme) {
      if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
        _saveUserEmailPassword(); // Save only if both fields are filled
      }
    } else {
      // Navigate to home if not remembering
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
  // Save user email and password
  Future<void> _saveUserEmailPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email',  emailController.text);
    prefs.setString('password', passwordController.text);
    prefs.setBool('isRememberMe', isRememberme);
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

    var request = http.Request('POST', Uri.parse('https://erp.darmesk.consulting/api/method/login'),);
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
      body: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: [
                Column(
                  children: [
                    Image.asset("images/frappe-logo.png", width: 50, height: 50),
                    SizedBox(height: 10),
                    Text(
                      "Login to Frappe",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      width: 300,
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.transparent,
                      ),
                      child: Column(
                        children: [
                          Form(
                            key: formState,
                            child: Column(
                              children: [
                                buildTextFormField(
                                  controller: emailController,
                                  hintText: 'Enter your email',
                                  isPassword: false,
                                  type: TextInputType.emailAddress,
                                  icon: Icons.email,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                      return "Must be a valid email address";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                buildTextFormField(
                                  controller: passwordController,
                                  hintText: 'Enter your password',
                                  isPassword: true,
                                  type: null,
                                  icon: Icons.lock,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: isRememberme,
                                      activeColor: Colors.blue,
                                      onChanged: (value) => _handleRememberMe(value!),
                                    ),
                                    Text("Remember me",
                                    )
                                  ],
                                ),
                                SizedBox(height: 22),
                                MaterialButton(
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onPressed: () {
                                    if (formState.currentState!.validate()) {
                                      postData(); // Call the postData method on login button press
                                    }
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 50,
                                    child: Center(
                                      child: _isLoading
                                          ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                          : Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    required bool isPassword,
    required TextInputType? type,
    required IconData icon,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      cursorColor: Colors.black,
      obscureText: isPassword && _obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon,color: Colors.blue),
        suffixIcon: isPassword ? suffixIcon : null,
        suffixIconColor: Colors.blue,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.black45),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      validator: validator,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _timer?.cancel(); // Cancel the timer
    super.dispose();
  }
}


