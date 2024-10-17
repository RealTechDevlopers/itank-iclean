import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../camera.dart';


class CameraAppView extends StatelessWidget {
  final CameraAppController controller = Get.put(CameraAppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera App with Location'),
      ),
      body: controller.cameraController == null || !controller.cameraController!.value.isInitialized
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          // Camera preview
          CameraPreview(controller.cameraController!),
          // Capture button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton(
                onPressed: controller.captureImage,
                child: Icon(Icons.camera),
              ),
            ),
          ),
          // Display latitude and longitude on the UI
          Align(
            alignment: Alignment.topCenter,
            child: Obx(() {
              return Text(
                'Lat: ${controller.latitude.value}, Long: ${controller.longitude.value}',
                style: TextStyle(color: Colors.white, fontSize: 18),
              );
            }),
          ),
        ],
      ),
    );
  }
}
