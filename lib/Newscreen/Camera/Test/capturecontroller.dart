import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
class ImagegeoController extends GetxController {
  var beforeImage = Rx<File?>(null);
  var duringImage = Rx<File?>(null);
  var afterImage = Rx<File?>(null);
  var beforeGeoTag = Rxn<Map<String, double>>();
  var duringGeoTag = Rxn<Map<String, double>>();
  var afterGeoTag = Rxn<Map<String, double>>();
  final ImagePicker picker = ImagePicker();
  Future<void> pickImageFromCamera(String section) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      Position? position = await _determinePosition();

      switch (section) {
        case 'before':
          beforeImage.value = File(pickedFile.path);
          if (position != null) {
            beforeGeoTag.value = {'latitude': position.latitude, 'longitude': position.longitude};
          }
          break;
        case 'during':
          duringImage.value = File(pickedFile.path);
          if (position != null) {
            duringGeoTag.value = {'latitude': position.latitude, 'longitude': position.longitude};
          }
          break;
        case 'after':
          afterImage.value = File(pickedFile.path);
          if (position != null) {
            afterGeoTag.value = {'latitude': position.latitude, 'longitude': position.longitude};
          }
          break;
      }
    }
  }

  // Method to determine the current location
  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, return early with null.
      Get.snackbar('Error', 'Location services are disabled.');
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, return early with null.
        Get.snackbar('Error', 'Location permissions are denied');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, handle appropriately.
      Get.snackbar('Error', 'Location permissions are permanently denied');
      return null;
    }

    // When permissions are granted, return the position.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}
