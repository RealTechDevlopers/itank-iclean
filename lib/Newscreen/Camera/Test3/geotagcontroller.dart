import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
class PictureController extends GetxController {
  Rx<File?> imageFile1 = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  Future<void> captureImage1() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null && File(pickedFile.path).existsSync()) {
      imageFile1.value = File(pickedFile.path);
    }else {
      print('Error: File not found');
    }
  }
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  // Merge the image with a text overlay (backgrounded text block)
  Future<File?> mergeImageWithTextOverlay() async {
    if (imageFile1.value == null) return null;
    // Get the current location (lat, lng)
    final position = await getCurrentLocation();
    // Decode the main image
    final image1 = img.decodeImage(await imageFile1.value!.readAsBytes());
    if (image1 == null) return null;
    // Text to overlay (latitude and longitude)
    final String text = 'Lat: ${position.latitude}, Long: ${position.longitude}';
    // Define size and padding for the text overlay
    const int fontSize = 14;
    const int textPadding = 10;
    const textBlockHeight = fontSize * 3 + textPadding * 2; // Estimate height for the text block
    // Create a new image for the text block with a background
    final textOverlay = img.Image(width: image1.width, height: textBlockHeight);
    // img.fill(textOverlay, color:); // Background color (black)
    // Draw white text on the text block
    img.drawString(
        textOverlay,
        // img.arial_14, // Use built-in smaller font
        text,
         font: img.arial14,                                // Y-coordinate
      // White text
    );
    // Overlay the text block on top of the original image
    // We place it at the top of the image (starting from y = 0)
    // img.copyInto(image1, textOverlay, dstY: 0, blend: true);
    // Save the merged image with the text overlay
    final mergedFilePath = '${imageFile1.value!.parent.path}/merged_image_with_overlay.jpg';
    final mergedFile = File(mergedFilePath);
    await mergedFile.writeAsBytes(img.encodeJpg(image1));
    return mergedFile;
  }
}
