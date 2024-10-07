import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iclean/Test/pro_controller.dart';
import 'dash.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileCreationScreen extends StatefulWidget {
  @override
  _ProfileCreationScreenState createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  final ProfileController controller = Get.put(ProfileController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  File? _image;  // To store the selected image

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,  // Pick image button
              child: Text('Pick Profile Image'),
            ),
            _image != null ? Image.file(_image!, height: 100, width: 100) : Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.updateProfile(
                  nameController.text,
                  int.tryParse(ageController.text) ?? 0,
                  emailController.text,
                  _image?.path ?? '',  // Pass the image path
                );
                Get.to(() => HomeScreen()); // Navigate to HomeScreen
              },
              child: Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
