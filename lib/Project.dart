import 'package:flutter/material.dart';
import 'package:frappe_project/Theme/themeController.dart';
import 'package:frappe_project/drawer.dart';
import 'package:get/get.dart';

class ProjectScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();

    final String projectName = 'تجهيز غرفتي التسويق والاستوديو';
    final String expectedStartDate = '01-06-2024';
    final String expectedEndDate = '01-09-2024';
    final String status = 'Open';
    final String priority = 'High';
    final String projectType = 'Internal';
    final String isActive = 'Yes';
    final String completionMethod = 'Task Completion';
    final int completionPercentage = 0;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Project Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 20),

              Row(
                children: [
                  Text('Project Name:   ', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(projectName),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Is Active:   ', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(isActive),
                  SizedBox(width: 110),
                  Text('Completed:   ', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('$completionPercentage%'),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Start Date: ', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(expectedStartDate),
                  Spacer(),
                  Text('End Date: ', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(expectedEndDate),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Status: ', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(status),
                  Spacer(),
                  Text('Priority: ', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(priority),
                  Spacer(),
                  Text('Type: ', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(projectType),
                ],
              ),

              SizedBox(height: 40),
              _buildConnectionsSection(context, themeController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionsSection(BuildContext context,
      ThemeController themeController) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            color: themeController.isDarkMode.value
                ? themeController.darkTheme.secondaryHeaderColor
                : themeController.lightTheme.secondaryHeaderColor,
          ),
          padding: EdgeInsets.all(8),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text('Project',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              children: [
                _buildButton(context, 'Task'),
                _buildButton(context, 'Timesheet'),
                _buildButton(context, 'Issue'),
                _buildButton(context, 'Project Update'),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),

        // Material section with borders, but without divider lines
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            color: themeController.isDarkMode.value
                ? themeController.darkTheme.secondaryHeaderColor
                : themeController.lightTheme.secondaryHeaderColor,
          ),
          padding: EdgeInsets.all(8),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            // Remove the divider line inside ExpansionTile
            child: ExpansionTile(
              title: Text('Material',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              children: [
                _buildButton(context, 'Material Request'),
                _buildButton(context, 'BOM'),
                _buildButton(context, 'Stock Entry'),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            color: themeController.isDarkMode.value
                ? themeController.darkTheme.secondaryHeaderColor
                : themeController.lightTheme.secondaryHeaderColor,
          ),
          padding: EdgeInsets.all(8),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text('Sales',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              children: [
                _buildButton(context, 'Sales Order'),
                _buildButton(context, 'Delivery Note'),
                _buildButton(context, 'Sales Invoice'),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            color: themeController.isDarkMode.value
                ? themeController.darkTheme.secondaryHeaderColor
                : themeController.lightTheme.secondaryHeaderColor,
          ),
          padding: EdgeInsets.all(8),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text('Purchase',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              children: [
                _buildButton(context, 'Purchase Order'),
                _buildButton(context, 'Purchase Receipt'),
                _buildButton(context, 'Purchase Invoice'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: OutlinedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: TextStyle(color: Colors.black)),
            Icon(Icons.add, color: Colors.black),
          ],
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}