// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';
// import '../Dashboard/Home.dart';
// class AdminCreationControllerController extends GetxController {
//   var selectedImage = Rx<File?>(null);
//
//   var userName = ''.obs;
//   var userMobileNumber = ''.obs;
//
//   Future<void> pickImageFromCamera() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       selectedImage.value = File(pickedFile.path);
//     }
//   }
//
//   void registerUser(String name, String mobileNumber) {
//     if (name.isEmpty || mobileNumber.isEmpty || !RegExp(r'^\d{10}$').hasMatch(mobileNumber)) {
//       Get.snackbar(
//         'Error',
//         'Please fill in all fields',
//         backgroundColor: Colors.redAccent,
//         colorText: Colors.white,
//         duration: Duration(seconds: 1),
//           snackPosition:SnackPosition.BOTTOM
//       );
//     } else {
//       // Update observable fields
//       userName.value = name;
//       userMobileNumber.value = mobileNumber;
//
//       Get.snackbar(
//         'Success',
//         'User registered successfully',
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//         duration: Duration(seconds: 1),
//           snackPosition:SnackPosition.BOTTOM
//       );
//       Get.to(Home());
//     }
//   }
// }
