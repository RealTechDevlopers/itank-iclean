import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class Imageapicontroller extends GetxController {
  Rx<File?> beforeImage = Rx<File?>(null);
  var uploadProgress = 0.0;
  RxString latLong = ''.obs;
  RxBool isLoading = false.obs;
  final ImagePicker _picker = ImagePicker();

  // Function to pick image from camera with location and watermark
  Future<void> pickImageWithLocation(String section) async {
    try {
      isLoading.value = true;

      // Check location permissions
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
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);
        beforeImage.value = imageFile; // Assign image to 'before' section

        // Get the current location
        final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        latLong.value = 'Lat: ${position.latitude}, Long: ${position.longitude}';

        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        Placemark place = placemarks[0];
        String address = '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
        latLong.value += '\nAddress: $address';

        final DateTime now = DateTime.now();
        final String formattedDate = DateFormat('dd-MM-yyyy').format(now);
        final String formattedTime = DateFormat('HH:mm:ss').format(now);

        // Add watermark with location and title
        await _addWatermarkWithLocation(imageFile, position.latitude, position.longitude, section, "My Custom Title", formattedDate, formattedTime, address);
      } else {
        latLong.value = "No image selected";
      }
    } catch (e) {
      latLong.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }

  // Compress image before uploading
  Future<File> compressImage(File imageFile, {int quality = 85, int maxWidth = 800, int maxHeight = 800}) async {
    // Read the image file as bytes
    final img.Image? originalImage = img.decodeImage(imageFile.readAsBytesSync());

    // Resize the image to maxWidth/maxHeight while maintaining the aspect ratio
    final img.Image resizedImage = img.copyResize(originalImage!, width: maxWidth);

    // Get temporary directory to save compressed image
    final Directory tempDir = await getTemporaryDirectory();
    final String targetPath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Compress and encode to JPEG with the specified quality
    final File compressedImage = File(targetPath)..writeAsBytesSync(img.encodeJpg(resizedImage, quality: quality));

    return compressedImage; // Return the compressed image file
  }

  Future<void> _addWatermarkWithLocation(File originalImage, double latitude, double longitude, String section, String title, String date, String time, String address) async {
    final img.Image? image = img.decodeImage(await originalImage.readAsBytes());
    if (image == null) return;

    final String watermarkText = 'Lat: $latitude, Long: $longitude';
    final String dateText = 'Date: $date';
    final String timeText = 'Time: $time';
    final String addressText = 'Address: $address';

    int x = image.width - 2950;
    int y = image.height - 300;
    int yDate = image.height - 450;
    int yTime = image.height - 375;
    int yAddress = image.height - 225;

    img.fillRect(image, x1: image.width - 3000, y1: image.height - 500, x2: image.width - 60, y2: image.height - 150, color: img.ColorRgba8(0, 0, 0, 150));
    img.drawString(image,font: img.arial48, x:x, y:y, watermarkText);
    img.drawString(image, font:img.arial48, x:x, y:yDate, dateText);
    img.drawString(image, font:img.arial48, x:x, y:yTime, timeText);
    img.drawString(image, font:img.arial48, x:x, y:yAddress, addressText);

    final directory = await getApplicationDocumentsDirectory();
    final newImagePath = '${directory.path}/image_with_watermark_$section.png';
    File(newImagePath).writeAsBytesSync(img.encodePng(image));
    beforeImage.value = File(newImagePath); // Update image with watermark
  }

  Future<void> uploadImage(File selectedImage,String tankName,String imei) async {
    if (selectedImage == null) {
      Get.snackbar("Warning", "Please capture the image first", duration: Duration(seconds: 1));
      return;
    }

    try {
      isLoading.value = true;
      Dio dio = Dio();

      // Compress the image before uploading
      File compressedImage = await compressImage(selectedImage, quality: 80, maxWidth: 800);

      String fileName = compressedImage.path.split('/').last;

      // Prepare FormData for image upload
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(compressedImage.path, filename: fileName),
        'tank_name': tankName,
        'imei': imei,
      });

      log("Uploading image: $fileName");
      log("FormData fields: ${formData.fields}");
      log("FormData files: ${formData.files}");

      // Replace with your actual API endpoint
      String apiUrl = 'http://devftp.itank.io/water/iNeer\api\iclean.php';

      // Send POST request to upload image
      Response response = await dio.post(
        apiUrl,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data', // Set content type
        ),
        onSendProgress: (int sent, int total) {
          double progress = (sent / total) * 100; // Calculate progress percentage
          log("Upload progress: $progress%"); // Log upload progress
        },
      );

      // Handle the response
      if (response.statusCode == 200) {
        Get.snackbar("Success", "Image uploaded successfully");
      } else {
        Get.snackbar("Error", "Failed to upload image");
      }
    } catch (e) {
      // Handle errors
      log('Error uploading image: $e');
      Get.snackbar("Error", "Failed to upload image: $e");
    } finally {
      isLoading.value = false;  // Hide loading spinner
    }
  }
}
