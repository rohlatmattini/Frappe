import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:70,left: 10,right: 10), // Add padding around the Row
        child: Column(
          children: [

            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black),
                    // color: Colors.red, // Different color for visibility
                  ),
                  child: Center(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset("images/project.png",width: 50,height: 50,),
                        Text(
                          "Project",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 10,),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the boxes evenly
              children: [
                Expanded(
                  child: Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black),
                      // color: Colors.blue, // Background color for visibility
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          Image.asset("images/quality-control.png",width: 50,height: 50,),
                          Text(
                            "Quality",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Container(
                    width: 150,                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black),
                      // color: Colors.green, // Different color for visibility
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          Image.asset("images/ready-stock.png",width: 50,height: 50,),
                          Text(
                            "Stock",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],

            ),
          ],
        ),
      ),
    );
  }
}
