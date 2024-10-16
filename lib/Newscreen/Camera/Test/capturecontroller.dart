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
      Position? position = await _determinePosition(); // Get current position

      if (position != null) {
        switch (section) {
          case 'before':
            beforeImage.value = File(pickedFile.path);
            beforeGeoTag.value = {
              'latitude': position.latitude,
              'longitude': position.longitude
            };
            break;

          case 'during':
            duringImage.value = File(pickedFile.path);
            duringGeoTag.value = {
              'latitude': position.latitude,
              'longitude': position.longitude
            };
            break;

          case 'after':
            afterImage.value = File(pickedFile.path);
            afterGeoTag.value = {
              'latitude': position.latitude,
              'longitude': position.longitude
            };
            break;
        }
      } else {
        // If the location is not available, set geo-tag to null
        switch (section) {
          case 'before':
            beforeGeoTag.value = null;
            break;
          case 'during':
            duringGeoTag.value = null;
            break;
          case 'after':
            afterGeoTag.value = null;
            break;
        }
      }
    }
  }

  // Method to determine the current location
  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled.');
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error', 'Location permissions are permanently denied');
      return null;
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}
