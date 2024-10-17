import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

class CameraAppController extends GetxController {
  CameraController? cameraController;
  XFile? capturedImage;
  var latitude = ''.obs;
  var longitude = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  // Initialize the camera
  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras.first, ResolutionPreset.high);
    await cameraController!.initialize();
    update();
  }

  // Capture Image and overlay text
  Future<void> captureImage() async {
    try {
      XFile imageFile = await cameraController!.takePicture();
      Position position = await Geolocator.getCurrentPosition();

      latitude.value = position.latitude.toString();
      longitude.value = position.longitude.toString();

      File imageWithOverlay = await _addTextToImage(
        File(imageFile.path),
        latitude.value,
        longitude.value,
      );

      capturedImage = XFile(imageWithOverlay.path);
      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to capture image: $e');
    }
  }

  // Overlay latitude and longitude onto the image
  Future<File> _addTextToImage(File imageFile, String latitude, String longitude) async {
    final bytes = await imageFile.readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image originalImage = frameInfo.image;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint();

    // Draw the original image
    canvas.drawImage(originalImage, Offset.zero, paint);

    // Prepare the text to overlay
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Lat: $latitude\nLong: $longitude',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          shadows: [Shadow(blurRadius: 2, color: Colors.black, offset: Offset(1, 1))],
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: originalImage.width.toDouble());
    textPainter.paint(canvas, Offset(20, originalImage.height - 100));

    // Finalize the drawing
    final ui.Image finalImage = await recorder
        .endRecording()
        .toImage(originalImage.width, originalImage.height);
    final ByteData? byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    // Save the modified image to a new file
    final directory = await getApplicationDocumentsDirectory();
    final newPath = path.join(directory.path, 'image_with_location.png');
    final imageWithLocation = File(newPath);
    await imageWithLocation.writeAsBytes(uint8List);

    return imageWithLocation;
  }

  // Dispose the camera when not in use
  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
