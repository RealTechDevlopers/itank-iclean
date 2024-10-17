// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
// class CaptureController extends GetxController {
//   var image = Rx<File?>(null);
//   var latitude = ''.obs;
//   var longitude = ''.obs;
//   final ImagePicker _picker = ImagePicker();
//   Future<void> captureImage() async {
//     try {
//       final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//       if (pickedFile != null) {
//         Positioned position = await _determinePosition();
//         latitude.value = position.latitude.toString();
//         longitude.value = position.longitude.toString();
//
//         File imageFile = File(pickedFile.path);
//         File imageWithLocation = await _addTextToImage(imageFile, latitude.value, longitude.value);
//         image.value = imageWithLocation;
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Error capturing image: $e');
//     }
//   }
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied.');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied.');
//     }
//     return await Geolocator.getCurrentPosition();
//   }
//   Future<File> _addTextToImage(File imageFile, String latitude, String longitude) async {
//     final bytes = await imageFile.readAsBytes();
//     final ui.Codec codec = await ui.instantiateImageCodec(bytes);
//     final ui.FrameInfo frameInfo = await codec.getNextFrame();
//     final ui.Image originalImage = frameInfo.image;
//
//     final recorder = ui.PictureRecorder();
//     final canvas = Canvas(recorder);
//     final paint = Paint();
//     canvas.drawImage(originalImage, Offset.zero, paint);
//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: 'Lat: $latitude\nLong: $longitude',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 24,
//           shadows: [Shadow(blurRadius: 2, color: Colors.black, offset: Offset(1, 1))],
//         ),
//       ),
//       textDirection: TextDirection.ltr,
//     );
//     textPainter.layout(
//       minWidth: 0,
//       maxWidth: originalImage.width.toDouble(),
//     );
//     textPainter.paint(canvas, Offset(20, originalImage.height - 100));
//     final ui.Image finalImage = await recorder.endRecording().toImage(originalImage.width, originalImage.height);
//     final ByteData? byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);
//     final Uint8List uint8List = byteData!.buffer.asUint8List();
//     final directory = await getApplicationDocumentsDirectory();
//     final newPath = path.join(directory.path, 'image_with_location.png');
//     final imageWithLocation = File(newPath);
//     await imageWithLocation.writeAsBytes(uint8List);
//
//     return imageWithLocation;
//   }
// }
//
// extension on Positioned {
//   get longitude => null;
// }
