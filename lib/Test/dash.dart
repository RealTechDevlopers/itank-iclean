import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:io';

import 'package:iclean/Test/pro_controller.dart';

class HomeScreen extends StatelessWidget {
  final ProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => controller.imagePath.value.isNotEmpty
                      ? Image.file(File(controller.imagePath.value), height: 80, width: 80)
                      : Icon(Icons.person, size: 80)),
                  SizedBox(height: 10),
                  Obx(() => Text('Name: ${controller.name.value}', style: TextStyle(color: Colors.white, fontSize: 18))),
                  Obx(() => Text('Email: ${controller.email.value}', style: TextStyle(color: Colors.white, fontSize: 14))),
                ],
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                // Handle navigation or other actions
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                // Handle navigation or other actions
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profile Details:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Obx(() => Text('Name: ${controller.name.value}')),
            Obx(() => Text('Age: ${controller.age.value}')),
            Obx(() => Text('Email: ${controller.email.value}')),
            Obx(() => controller.imagePath.value.isNotEmpty
                ? Image.file(File(controller.imagePath.value), height: 100, width: 100)
                : Icon(Icons.person, size: 100)),
          ],
        ),
      ),
    );
  }
}
