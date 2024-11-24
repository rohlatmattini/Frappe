import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frappe_project/drawer.dart';
import 'package:get/get.dart';
import 'Project.dart';
import 'Theme/themeController.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => HomeContent();
}

class HomeContent extends State<Homepage> {
  final ThemeController themeController = Get.find();
  List project = [
    {"name": "first project", "percentage": "90 %"},
    {"name": "second project", "percentage": "30 %"},
    {"name": "third project", "percentage": "50 %"},
    {"name": "fourth project", "percentage": "9 %"},
    {"name": "fifth project", "percentage": "65 %"},
    {"name": "first project", "percentage": "90 %"},
    {"name": "first project", "percentage": "90 %"},
  ];

  Color getProgressColor(double percentage) {
    if (percentage <= 40) {
      return Colors.red;
    } else if (percentage > 40 && percentage <= 70) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black26),
                      child: Icon(
                        Icons.person,
                        size: 40,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Hi, person",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),

          Expanded(
            child: ListView.builder(
              itemCount: project.length,
              itemBuilder: (context, int i) {
                double percentage = double.parse(
                    project[i]["percentage"].replaceAll('%', ''));

                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ProjectScreen()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: themeController.isDarkMode.value
                              ? themeController.darkTheme.primaryColor
                              : themeController.lightTheme.primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              project[i]["name"],
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: percentage / 100,
                                  strokeWidth: 4,
                                  strokeAlign: 5,
                                  backgroundColor: Colors.grey[300],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      getProgressColor(percentage)),
                                ),
                                Text(
                                  project[i]["percentage"],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
