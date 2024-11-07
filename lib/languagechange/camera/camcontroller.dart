import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import '../../Newscreen/global/Globalvar.dart';
import '../../Newscreen/jsondashboard/model.dart';

class Imagecontroller extends GetxController {
  Rx<File?> beforeImage = Rx<File?>(null);
  Rx<File?> duringImage = Rx<File?>(null);
  Rx<File?> afterImage = Rx<File?>(null);
  RxBool isBeforeLoading = false.obs;
  RxBool isDuringLoading = false.obs;
  RxBool isAfterLoading = false.obs;
  var compressedImage = Rxn<File>();
  var uploadProgress = 0.0;
  RxString latLong = ''.obs;
  RxBool isLoading = false.obs;
  final ImagePicker _picker = ImagePicker();

  void logImageSize(File imageFile, String description) {
    final int bytes = imageFile.lengthSync();
    final String formattedSize = formatBytes(bytes);
    print("$description Image Size: $formattedSize");
  }

  String formatBytes(int bytes, [int decimals = 2]) {
    const suffixes = ["B", "KB", "MB", "GB"];
    var i = 0;
    double size = bytes.toDouble();
    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    return "${size.toStringAsFixed(decimals)} ${suffixes[i]}";
  }

  // Function to pick an image, log the size, and add a watermark
  Future<void> pickImageWithLocation(String section) async {
    try {
      isLoading.value = true;

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

      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);
        beforeImage.value = imageFile;
        logImageSize(imageFile, "Original");

        final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        latLong.value = 'Lat: ${position.latitude}, Long: ${position.longitude}';

        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        Placemark place = placemarks[0];
        String address = '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
        latLong.value += '\nAddress: $address';

        final DateTime now = DateTime.now();
        final String formattedDate = DateFormat('dd-MM-yyyy').format(now);
        final String formattedTime = DateFormat('HH:mm:ss').format(now);

        await _addWatermarkWithLocation(
          imageFile,
          position.latitude,
          position.longitude,
          section,
          "My Custom Title",
          formattedDate,
          formattedTime,
          address,
        );
        logImageSize(imageFile, "Watermarked");
      } else {
        latLong.value = "No image selected";
      }
    } catch (e) {
      latLong.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }

  Future<File> compressImage(File imageFile, {int quality = 85, int maxWidth = 800, int? maxHeight}) async {
    final img.Image? originalImage = img.decodeImage(imageFile.readAsBytesSync());
    if (originalImage == null) throw Exception("Invalid image file");

    // Calculate maxHeight based on aspect ratio if not provided
    maxHeight ??= (originalImage.height * maxWidth / originalImage.width).toInt();

    final img.Image resizedImage = img.copyResize(
      originalImage,
      width: maxWidth,
      height: maxHeight,
    );

    final Directory tempDir = await getTemporaryDirectory();
    final String targetPath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    final File compressedImage = File(targetPath)
      ..writeAsBytesSync(img.encodeJpg(resizedImage, quality: quality));
    logImageSize(compressedImage, "Compressed");
    return compressedImage;
  }

  Future<void> _addWatermarkWithLocation(
      File originalImage,
      double latitude,
      double longitude,
      String section,
      String title,
      String date,
      String time,
      String address,
      ) async {
    final img.Image? image = img.decodeImage(await originalImage.readAsBytes());
    if (image == null) return;

    final String watermarkText = 'Lat: $latitude, Long: $longitude';
    final String dateText = 'Date: $date';
    final String timeText = 'Time: $time';
    final String addressText = 'Address: $address';
    int padding = (image.width * 0.05).toInt();
    int textHeight = (image.height * 0.04).toInt();
    int xPosition = padding;
    int yPositionWatermark = image.height - padding - textHeight * 3;
    int yPositionDate = yPositionWatermark + textHeight;
    int yPositionTime = yPositionDate + textHeight;
    int yPositionAddress = yPositionTime + textHeight;

    img.fillRect(image,
        x1: xPosition - padding ~/ 2,
        y1: yPositionWatermark - padding ~/ 2,
        x2: image.width - padding,
        y2: image.height - padding ~/ 4,
        color: img.ColorRgba8(0, 0, 0, 150));

    img.drawString(image, font: img.arial48, x: xPosition, y: yPositionWatermark, watermarkText);
    img.drawString(image, font: img.arial48, x: xPosition, y: yPositionDate, dateText);
    img.drawString(image, font: img.arial48, x: xPosition, y: yPositionTime, timeText);
    img.drawString(image, font: img.arial48, x: xPosition, y: yPositionAddress, addressText);

    final directory = await getApplicationDocumentsDirectory();
    final newImagePath = '${directory.path}/image_with_watermark_$section.png';
    File(newImagePath).writeAsBytesSync(img.encodePng(image));

    if (section.toLowerCase() == 'before') {
      beforeImage.value = File(newImagePath);
    } else if (section.toLowerCase() == 'during') {
      duringImage.value = File(newImagePath);
    } else if (section.toLowerCase() == 'after') {
      afterImage.value = File(newImagePath);
    }
  }

  Future<void> uploadImage(File selectedImage, String tankName, String section, Tank tank) async {
    if (selectedImage == null) {
      Get.snackbar("Warning", "Please capture the image first", duration: Duration(seconds: 1));
      return;
    }

    try {
      isLoading.value = true;
      Dio dio = Dio();

      File compressedImage = await compressImage(selectedImage, quality: 80);

      String fileName = compressedImage.path.split('/').last;

      FormData formData = FormData.fromMap({
        'action': section,
        'image': await MultipartFile.fromFile(compressedImage.path, filename: fileName),
        'date': DateTime.now(),
        'latlong': latLong.string,
        'name': tank.name,
        'imei': tank.imei,
        'tank_name': tankName,
        'updatedBy': tank.username,
        // 'id': tank.id,
      });

      String apiUrl = 'http://devftp.itank.io/water/ineer/api/icleanApi/iclean_imgUpload.php';
      Response response = await dio.post(
        apiUrl,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
        onSendProgress: (int sent, int total) {
          double progress = (sent / total) * 100;
          log("Upload progress: $progress%");
        },
      );
      if (response.statusCode == 200) {
        tankController.fetchTanks();
        Get.snackbar("Success", "Image uploaded successfully",
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Failed to upload image",
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      log('Error uploading image: $e');
      Get.snackbar("Error", "Failed to upload image: $e",
          duration: const Duration(seconds: 1),
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
