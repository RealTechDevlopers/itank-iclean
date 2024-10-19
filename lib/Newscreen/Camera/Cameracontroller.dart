import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class ImageController extends GetxController {
  var beforeImage = Rx<File?>(null);
  var duringImage = Rx<File?>(null);
  var afterImage = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();
  Future<void> pickImageFromCamera(String section) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      switch (section) {
        case 'before':
          beforeImage.value = File(pickedFile.path);
          break;
        case 'during':
          duringImage.value = File(pickedFile.path);
          break;
        case 'after':
          afterImage.value = File(pickedFile.path);
          break;
      }
    }
  }
}