import 'dart:io';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = ''.obs;
  var age = 0.obs;
  var email = ''.obs;
  var imagePath = ''.obs;  // For storing the image path

  void updateProfile(String newName, int newAge, String newEmail, String newImagePath) {
    name.value = newName;
    age.value = newAge;
    email.value = newEmail;
    imagePath.value = newImagePath;  // Update image path
  }
}
