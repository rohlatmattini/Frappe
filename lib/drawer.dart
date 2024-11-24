import 'package:flutter/material.dart';
import 'package:frappe_project/Login.dart';
import 'package:frappe_project/Project.dart';
import 'package:frappe_project/Theme/themeController.dart';
import 'package:frappe_project/homepage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'Locale/Locale.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => MyDrawer1();
}

class MyDrawer1 extends State<MyDrawer> {
  final List<String> languages = ['en', 'ar'];

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();
    MyLocaleController controllerLang = Get.find();

    String selectedLanguage = controllerLang.currentLocale.value.languageCode;

    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 100),
        child: Column(
          children: [
            // User Information
            Row(
              children: [
                Expanded(
                  child: InkWell(
                   onTap:(){
                     showDialog(
                       context: context,
                       builder: (BuildContext context) {
                         return UserProfileDialog();
                       },
                     );
                   },
                    child: Card(
                      color: themeController.isDarkMode.value
                          ? themeController.darkTheme.secondaryHeaderColor
                          : themeController.lightTheme.secondaryHeaderColor,
                      child: ListTile(
                        tileColor: Colors.transparent,
                        leading: Icon(Icons.person, color: Colors.indigo),
                        title: Text(
                          "user name",
                          style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 25),
                        ),
                        subtitle: Text(
                          "email",
                          style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),

                ),
              ],
            ),

            // Project List
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: themeController.isDarkMode.value
                        ? themeController.darkTheme.secondaryHeaderColor
                        : themeController.lightTheme.secondaryHeaderColor,
                    child: ListTile(
                      tileColor: Colors.transparent,
                      leading: Icon(Icons.filter_frames_sharp, color: Colors.indigo),
                      title: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Homepage()),
                          );
                        },
                        child: Text(
                          "projects".tr,
                          style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Dark Mode Toggle
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: themeController.isDarkMode.value
                        ? themeController.darkTheme.secondaryHeaderColor
                        : themeController.lightTheme.secondaryHeaderColor,
                    child: ListTile(
                      leading: Icon(Icons.dark_mode_rounded, color: Colors.indigo),
                      title: Text(
                        "Dark mode".tr,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                      trailing: Obx(() => Switch(
                          activeColor: Colors.indigo,
                          value: themeController.isDarkMode.value,
                          onChanged: (state) {
                            themeController.changeTheme();
                          })),
                    ),
                  ),
                ),
              ],
            ),

            // Language Selection Dropdown
            Row(
              children: [
                Expanded(
                  child: Card(
                    color:  themeController.isDarkMode.value
                        ? themeController.darkTheme.secondaryHeaderColor
                        : themeController.lightTheme.secondaryHeaderColor,
                    child: ListTile(
                      leading: Icon(Icons.language, color: Colors.indigo),
                      title: Text(
                        "Language".tr,
                        style: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyLarge!.color),
                      ),
                      trailing: DropdownButton<String>(
                        value: selectedLanguage,
                        icon: Icon(Icons.arrow_downward, color: Colors.indigo),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                        underline: Container(
                          height: 2,
                          color: Colors.indigo,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedLanguage = newValue!;
                            controllerLang.changeLang(newValue);
                          });
                        },
                        items: languages.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value == 'en' ? 'English' : 'Arabic',
                              style: TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: Card(
                    color: themeController.isDarkMode.value
                        ? themeController.darkTheme.secondaryHeaderColor
                        : themeController.lightTheme.secondaryHeaderColor,
                    child: ListTile(
                      tileColor: Colors.transparent,
                      leading: Icon(Icons.rule, color: Colors.indigo),
                      title: TextButton(
                        onPressed: () {
                        },
                        child: Text(
                          "Term & Condition".tr,
                          style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: themeController.isDarkMode.value
                        ? themeController.darkTheme.secondaryHeaderColor
                        : themeController.lightTheme.secondaryHeaderColor,
                    child: ListTile(
                      tileColor: Colors.transparent,
                      leading: Icon(Icons.logout_sharp, color: Colors.indigo),
                      title: TextButton(
                        onPressed: () async {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                                (route) => false,
                          );
                        },
                        child: Text(
                          "Logout".tr,
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),

            Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class UserProfileDialog extends StatefulWidget {
  @override
  _UserProfileDialogState createState() => _UserProfileDialogState();
}

class _UserProfileDialogState extends State<UserProfileDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("User Profile"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "User Information",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Username: John Doe"),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text("Email: johndoe@example.com"),
              ),
              Divider(),

              Text(
                "Change Password",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _currentPasswordController,
                decoration: InputDecoration(
                  labelText: "Current Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: "New Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Confirm New Password Field
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: "Confirm New Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  } else if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text("Update Password"),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
