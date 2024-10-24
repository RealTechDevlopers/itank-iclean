// import 'dart:developer';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart' hide FormData ,MultipartFile,Response;
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:mime/mime.dart';
// import 'package:http_parser/http_parser.dart'; // For handling multipart/form-data
//
// class ImageController extends GetxController {
//   // Images for different sections
//   Rx<File?> beforeImage = Rx<File?>(null);
//   Rx<File?> duringImage = Rx<File?>(null);
//   Rx<File?> afterImage = Rx<File?>(null);
//   File? _image;
//   var uploadProgress = 0.0;
//   // Common properties
//   RxString latLong = ''.obs;
//   RxBool isLoading = false.obs;
//   final ImagePicker _picker = ImagePicker();
//
//   // Future<void> pickImageFromCamera() async {
//   //   final pickedFile = await _picker.pickImage(source: ImageSource.camera); // Pick from camera
//   //
//   //   if (pickedFile != null) {
//   //     selectedImage.value = File(pickedFile.path); // Update the selected image
//   //   }
//   // }
//
//   Future<void> pickImageWithLocation(String section) async {
//     try {
//       // Start loading state
//       isLoading.value = true;
//
//       // Small delay to ensure the loading state is rendered
//       await Future.delayed(Duration(milliseconds: 100));
//
//       // Location permission handling
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         latLong.value = "Location services are disabled.";
//         isLoading.value = false;
//         return;
//       }
//
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           latLong.value = "Location permissions are denied";
//           isLoading.value = false;
//           return;
//         }
//       }
//
//       if (permission == LocationPermission.deniedForever) {
//         latLong.value = "Location permissions are permanently denied";
//         isLoading.value = false;
//         return;
//       }
//
//       // Pick image from camera
//       final XFile? pickedFile = await _picker.pickImage(
//           source: ImageSource.camera);
//       if (pickedFile != null) {
//         final File imageFile = File(pickedFile.path);
//
//         // Assign the image to the appropriate section
//         switch (section) {
//           case 'before':
//             beforeImage.value = imageFile;
//             break;
//           case 'during':
//             duringImage.value = imageFile;
//             break;
//           case 'after':
//             afterImage.value = imageFile;
//             break;
//         }
//
//         // Get the current location
//         final position = await Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.high);
//         latLong.value =
//         'Lat: ${position.latitude}, Long: ${position.longitude}';
//
//         // Reverse geocoding to get the address
//         List<Placemark> placemarks = await placemarkFromCoordinates(
//             position.latitude, position.longitude);
//         Placemark place = placemarks[0];
//
//         // Create a readable address
//         String address = '${place.street}, ${place.locality}, ${place
//             .postalCode}, ${place.country}';
//         latLong.value +=
//         '\nAddress: $address'; // Append address to latLong string
//
//         final DateTime now = DateTime.now();
//         final String formattedDate = DateFormat('dd-MM-yyyy').format(now);
//         final String formattedTime = DateFormat('HH:mm:ss').format(now);
//
//         // Add watermark with latitude/longitude and a title
//         await _addWatermarkWithLocation(
//             imageFile,
//             position.latitude,
//             position.longitude,
//             section,
//             "My Custom Title",
//             formattedDate,
//             formattedTime,
//             address
//         );
//
//         // After watermarking, upload the image
//         await uploadImage(imageFile, section);
//       } else {
//         latLong.value = "No image selected";
//       }
//     } catch (e) {
//       latLong.value = "Error: $e";
//     } finally {
//       // Stop loading state
//       isLoading.value = false;
//     }
//   }
//   Future<void> uploadImage(File selectedImage,  String section) async {
//     if (selectedImage.path == null) {
//       Get.snackbar("Error", "Please select an image first");
//       return;
//     }
//
//     Dio dio = Dio();
//     String fileName = selectedImage.path.split('/').last;
//
//     // Prepare the FormData with the selected image
//     FormData formData = FormData.fromMap({
//       'image': await MultipartFile.fromFile(selectedImage.path, filename: fileName),
//     });
//
//     // Log the form data fields
//     for (var field in formData.fields) {
//       log("FormData Field: ${field.key} = ${field.value}");
//     }
//
//     try {
//       // Send the POST request with the image and track progress
//       Response response = await dio.post(
//         '', // Replace with your API endpoint
//         data: formData,
//         options: Options(
//           contentType: 'multipart/form-data', // Ensure content type is multipart
//         ),
//         onSendProgress: (int sent, int total) {
//           uploadProgress = sent / total; // Update the progress
//           log("Upload progress: ${(uploadProgress * 100).toInt()}%");
//         },
//       );
//
//       // Handle the response
//       if (response.statusCode == 200) {
//         Get.snackbar("Success", "Upload successful");
//       } else {
//         Get.snackbar("Error", "Failed to upload");
//       }
//     } catch (e) {
//       log('Error: $e');
//       Get.snackbar("Error", e.toString());
//     }
//   }
// }
//
//   Future<void> _addWatermarkWithLocation(File originalImage,
//       double latitude,
//       double longitude,
//       String section,
//       String title,
//       String date,
//       String time,
//       String address) async {
//     final img.Image? image = img.decodeImage(await originalImage.readAsBytes());
//     if (image == null) return;
//
//     // Define watermark text (latitude, longitude, and title)
//     final String watermarkText = 'Lat: $latitude, Long: $longitude';
//     final String titleText = title;
//     final String addressText = 'Address: $address';
//     final String dateText = 'Date: $date';
//     final String timeText = 'Time: $time';
//
//     // Define position for the text box
//     int boxX = image.width - 3000;
//     int boxY = image.height - 500;
//     int boxWidth = 2940; // Width of the rectangle
//     int boxHeight = 350; // Height of the rectangle
//
//     // Define position for watermark
//     int x = image.width - 2950;
//     int y = image.height - 300;
//     int yDate = image.height - 450;
//     int yTime = image.height - 375;
//     int yAddress = image.height - 225;
//
//     // Add watermark text to the image
//     img.fillRect(image,
//         x1: boxX,
//         y1: boxY,
//         x2: boxX + boxWidth,
//         y2: boxY + boxHeight,
//         color: img.ColorRgba8(0, 0, 0, 150));
//
//     img.drawString(image, font: img.arial24, x: x, y: -40, titleText);
//     img.drawString(image, font: img.arial48, x: x, y: y, watermarkText);
//     img.drawString(image, font: img.arial48, x: x, y: yDate, dateText);
//     img.drawString(image, font: img.arial48, x: x, y: yTime, timeText);
//     img.drawString(image, font: img.arial48, x: x, y: yAddress, addressText);
//
//     // Get directory to save watermarked image
//     final directory = await getApplicationDocumentsDirectory();
//     final newImagePath = '${directory.path}/image_with_watermark_$section.png';
//
//     // Save the modified image
//     final newFile = File(newImagePath);
//     newFile.writeAsBytesSync(img.encodePng(image));
//
//     // Update the appropriate image reference to the watermarked image
//     switch (section) {
//       case 'before':
//         beforeImage.value = newFile;
//         break;
//       case 'during':
//         duringImage.value = newFile;
//         break;
//       case 'after':
//         afterImage.value = newFile;
//         break;
//     }
//
//     // Optional: Update the observable to reflect the new image path
//     latLong.value = 'Image with Lat/Long saved at: $newImagePath';
//   }
//
//   // Function to upload the image to a server
//   // Future<void> uploadImage(File imageFile, String section) async {
//   //   try {
//   //     isLoading.value = true;
//   //
//   //     // Define the server URL where you want to upload the image
//   //     var url = Uri.parse(
//   //           'https://your-server.com/upload'); // Replace with actual URL
//   //
//   //     // Determine the MIME type of the image
//   //     final mimeTypeData = lookupMimeType(imageFile.path)?.split('/') ??
//   //         ['image', 'jpeg'];
//   //
//   //     // Create a multipart request
//   //     var request = http.MultipartRequest('POST', url);
//   //
//   //     // Attach the file
//   //     request.files.add(await http.MultipartFile.fromPath(
//   //       'image',
//   //       imageFile.path,
//   //       contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
//   //     ));
//   //
//   //     // Add additional fields if needed
//   //     request.fields['section'] = section;
//   //
//   //     // Send the request
//   //     var response = await request.send();
//   //
//   //     if (response.statusCode == 200) {
//   //       Get.snackbar("Success", "Image uploaded successfully");
//   //     } else {
//   //       Get.snackbar("Error", "Failed to upload image");
//   //     }
//   //   } catch (e) {
//   //     print("Error uploading image: $e");
//   //     Get.snackbar("Error", "Error uploading image");
//   //   } finally {
//   //     isLoading.value = false;
//   //   }
//   // }
//   // Function to download the image to device storage
//   Future<void> downloadImage(File image) async {
//     try {
//       // Get the directory to save the image
//       final directory = await getExternalStorageDirectory();
//       final String path = directory!.path;
//
//       // Create a new file path with a timestamp
//       final File newImage = File('$path/${DateTime.now().millisecondsSinceEpoch}.png');
//
//       // Write the image file to the new path
//       await newImage.writeAsBytes(await image.readAsBytes());
//
//       // Display success message
//       Get.snackbar("Success", "Image downloaded successfully");
//     } catch (e) {
//       print("Error downloading image: $e");
//       Get.snackbar("Error", "Failed to download image");
//     }
//   }
