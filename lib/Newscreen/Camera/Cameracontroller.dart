import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class ImageController extends GetxController {
  // Images for different sections
  Rx<File?> beforeImage = Rx<File?>(null);
  Rx<File?> duringImage = Rx<File?>(null);
  Rx<File?> afterImage = Rx<File?>(null);

  // Common properties
  RxString latLong = ''.obs;
  RxBool isLoading = false.obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageWithLocation(String section) async {
    try {
      // Start loading state
      isLoading.value = true;

      // Small delay to ensure the loading state is rendered
      await Future.delayed(Duration(milliseconds: 100));

      // Location permission handling
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
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);

        // Assign the image to the appropriate section
        switch (section) {
          case 'before':
            beforeImage.value = imageFile;
            break;
          case 'during':
            duringImage.value = imageFile;
            break;
          case 'after':
            afterImage.value = imageFile;
            break;
        }

        // Get the current location
        final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        latLong.value =
            'Lat: ${position.latitude}, Long: ${position.longitude}';

        // Reverse geocoding to get the address
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        Placemark place = placemarks[0];

        // Create a readable address
        String address =
            '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
        latLong.value +=
            '\nAddress: $address'; // Append address to latLong string

        final DateTime now = DateTime.now();
        final String formattedDate = DateFormat('dd-MM-yyyy').format(now);
        final String formattedTime = DateFormat('HH:mm:ss').format(now);

        // Add watermark with latitude/longitude and a title
        await _addWatermarkWithLocation(
            imageFile,
            position.latitude,
            position.longitude,
            section,
            "My Custom Title",
            formattedDate,
            formattedTime,
           address
        );
      } else {
        latLong.value = "No image selected";
      }
    } catch (e) {
      latLong.value = "Error: $e";
    } finally {
      // Stop loading state
      isLoading.value = false;
    }
  }

  Future<void> _addWatermarkWithLocation(
      File originalImage,
      double latitude,
      double longitude,
      String section,
      String title,
      String date,
      String time,
      String address
      ) async {
    final img.Image? image = img.decodeImage(await originalImage.readAsBytes());
    if (image == null) return;

    // final fontData = await rootBundle.load('assets/fonts/arial.ttf');
    // final font = img.BitmapFont.fromTtf(fontData.buffer.asUint8List(), 60);

    // Define watermark text (latitude, longitude, and title)
    //final img.Image scaledImage = img.copyResize(image, width: image.width * 2, height: image.height * 2);
    final String watermarkText = 'Lat: $latitude, Long: $longitude';
    final String titleText = title;
    final String addressText = 'Address: $address';
    // const String titleText = "hello";
    final String dateText = 'Date: $date';
    final String timeText = 'Time: $time';

    //final int boxColor = img.getColor(0, 0, 0, 150);

    // Define position for the text box
    int boxX = image.width - 3000;
    int boxY = image.height - 500;
    int boxWidth = 2940; // Width of the rectangle
    int boxHeight = 350; // Height of the rectangle

    // Define position for watermark
    int x = image.width - 2950;
    int y = image.height - 300;
    // int yTitle = image.height - 700;
    // int yLocation = image.height - 550;
    int yDate = image.height - 450;
    int yTime = image.height - 375;
    int yAddress = image.height - 225;

    //  final int strokeColor = img.getColor(0, 0, 0); // Black for stroke
    // Add watermark text to the image
    img.fillRect(image,
        x1: boxX,
        y1: boxY,
        x2: boxX + boxWidth,
        y2: boxY + boxHeight,
        color: img.ColorRgba8(0, 0, 0, 150));

    img.drawString(
      image,
      font: img.arial24,
      x: x,
      y: -40,
      titleText,
    );
    img.drawString(
        image,
        font: img.arial48,
        x: x,
        y: y,
        watermarkText,
        color: img.ColorRgb8(
          255,
          255,
          255,
        ));
    // img.drawString(scaledImage, font:img.arial24, watermarkText);
    img.drawString(image, font: img.arial48, x: x, y: yDate, dateText);
    img.drawString(image, font: img.arial48, x: x, y: yTime, timeText);
    img.drawString(image, font: img.arial48, x: x, y: yAddress, addressText);

    // Get directory to save watermarked image
    final directory = await getApplicationDocumentsDirectory();
    final newImagePath = '${directory.path}/image_with_watermark_$section.png';

    // Save the modified image
    final newFile = File(newImagePath);
    newFile.writeAsBytesSync(img.encodePng(image));

    // Update the appropriate image reference to the watermarked image
    switch (section) {
      case 'before':
        beforeImage.value = newFile;
        break;
      case 'during':
        duringImage.value = newFile;
        break;
      case 'after':
        afterImage.value = newFile;
        break;
    }

    // Optional: Update the observable to reflect the new image path
    latLong.value = 'Image with Lat/Long saved at: $newImagePath';
  }
}
