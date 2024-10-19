import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img; // For image manipulation
import 'package:path_provider/path_provider.dart'; // For saving files
class writeController extends GetxController {
  Rx<File?> pickedImage = Rx<File?>(null);
  RxString latLong = ''.obs;
  final ImagePicker _picker = ImagePicker();
  Future<void> pickImageWithLocation() async {
    try {
      // Request permission before fetching the location
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        latLong.value = "Location services are disabled.";
       // return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          latLong.value = "Location permissions are denied";
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        latLong.value = "Location permissions are permanently denied";
        return;
      }
      // Pick image from camera
      final XFile? imageFile = await _picker.pickImage(source: ImageSource.camera);

      if (imageFile != null) {
        pickedImage.value = File(imageFile.path);
        // Get curren location
        final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        latLong.value = 'Lat: ${position.latitude}, Long: ${position.longitude}';

        // Add lat/long as text inside the image and save it
        await _addLatLongToImage(pickedImage.value!, position.latitude, position.longitude);
      } else {
        latLong.value = "No image selected";
      }
    } catch (e) {
      latLong.value = "Error: $e";
    }
  }
  Future<void> _addLatLongToImage(File originalImage, double latitude, double longitude) async {
    // Read the image file as a byte array
    final img.Image? image = img.decodeImage(await originalImage.readAsBytes());

    if (image == null) {
      return; // Exit if the image cannot be read
    }

    // Define the text to overlay (latitude and longitude)
    final text = 'Lat: $latitude, Long: $longitude';

    // Add text to the image (bottom left corner)
    img.drawString(image, img.arial_48, 10, image.height - 60, text, font: arial24);

    // Get the directory to save the modified image
    final directory = await getApplicationDocumentsDirectory();
    final newImagePath = '${directory.path}/image_with_latlong.png';

    // Save the modified image
    final newFile = File(newImagePath);
    newFile.writeAsBytesSync(img.encodePng(image));

    // Update the pickedImage to reflect the modified image with text
    pickedImage.value = newFile;

    // Optional: Update the latLong observable to show new image path (for debugging)
    latLong.value = 'Saved with Lat/Long at: $newImagePath';
  }
}
