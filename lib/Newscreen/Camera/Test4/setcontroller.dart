import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class writeController extends GetxController {
  Rx<File?> pickedImage = Rx<File?>(null);
  RxString latLong = ''.obs;
  RxBool isLoading = false.obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageWithLocation() async {
    try {
      isLoading.value = true;
      // Request location permission
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        latLong.value = "Location services are disabled.";
        isLoading.value = false;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          latLong.value = "Location permissions are denied";
          isLoading.value = false;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        latLong.value = "Location permissions are permanently denied";
        isLoading.value = false;
        return;
      }

      // Pick image from camera
      final XFile? imageFile = await _picker.pickImage(source: ImageSource.camera);
      if(imageFile != null) {
        pickedImage.value = File(imageFile.path);
        // Get current location
        final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        latLong.value = 'Lat: ${position.latitude}, Long: ${position.longitude}';

        // Add lat/long to the image as a watermark
        await _addWatermarksWithBlackLayer(pickedImage.value!, position.latitude, position.longitude, "My Custom Title");
      } else {
        latLong.value = "No image selected";
      }
    } catch (e) {
     // print("Error: $e");
      latLong.value = "Error: $e";
    }finally{
      isLoading.value = false;
    }
  }


  Future<void> _addWatermarksWithBlackLayer(File originalImage, double latitude, double longitude, String title) async {
    // Read the image file as a byte array
    final img.Image? image = img.decodeImage(await originalImage.readAsBytes());
    if (image == null) {
      return; // Exit if the image cannot be read
    }


    // Define the text to overlay (latitude and longitude)
    final String watermarkText = 'Lat: $latitude, Long: $longitude';
    final String titleText = title;

    //final int textColor = img.getColor(255, 0, 0, 255);
    //final int textColor = img.getColor(255, 255, 255, 255);
    int x = image.width - 600;
    int y = image.height - 600;
    // Draw the watermark text (bottom-left corner)
    //  *OE* img.drawString(image, font: img.arial48, x:10, y:image.height - 60, watermarkText);
    img.drawString(image, font: img.arial48, x:x, y:y, watermarkText);

    // Get the directory to save the modified image
    final directory = await getApplicationDocumentsDirectory();
    final newImagePath = '${directory.path}/image_with_watermark.png';

    // Save the modified image with the watermark
    final newFile = File(newImagePath);
    newFile.writeAsBytesSync(img.encodePng(image)) ;

    // Update the pickedImage to reflect the watermarked image
    pickedImage.value = newFile;

    // Optional: Update the latLong observable to show the new image path (for debugging)
    latLong.value = 'Saved with Lat/Long at: $newImagePath';
  }
}