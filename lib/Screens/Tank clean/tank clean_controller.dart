import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TankScreenController extends GetxController {
  File? beforeImage;
  File? afterImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> onBeforeImageTap() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      beforeImage = File(pickedFile.path);
      update(); // Refresh the UI
    }
  }

  Future<void> onAfterImageTap() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      afterImage = File(pickedFile.path);
      update(); // Refresh the UI
    }
  }

  // void onBeforeImageTap() {
  //   Get.snackbar('Before Clean', 'Before Clean image tapped');
  // }

  // void onAfterImageTap() {
  //   Get.snackbar('After Clean', 'After Clean image tapped');
  // }
}
