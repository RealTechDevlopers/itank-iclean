import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'setcontroller.dart'; // Assuming your controller file is imported like this

class WriteScreen extends StatelessWidget {
  final writeController controller = Get.put(writeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Capture Image with Lat/Long')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Button to pick image from camera
            ElevatedButton(
              onPressed: () async {
                await controller.pickImageWithLocation();
                if (controller.pickedImage.value != null) {
                  // Open the modal to display the image after capturing
                  showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return Obx(() {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          height: 400,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Captured Image with Lat/Long',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                controller.latLong.value, // Displays the lat/long or saved path
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              controller.pickedImage.value != null
                                  ? Image.file(
                                File(controller.pickedImage.value!.path),
                                width: double.infinity,
                                height: 250,
                                fit: BoxFit.cover,
                              )
                                  : const Text('No image selected'),
                            ],
                          ),
                        );
                      });
                    },
                  );
                }
              },
              child: const Text('Capture Image'),
            ),
            const SizedBox(height: 20),
            Obx(() {
              return controller.pickedImage.value != null
                  ? Image.file(
                File(controller.pickedImage.value!.path),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              )
                  : const Text('No image selected');
            }),
          ],
        ),
      ),
    );
  }
}
