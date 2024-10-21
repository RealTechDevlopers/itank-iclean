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
        child: Obx(() {
          if (controller.isLoading.value) {
            // Show the loading indicator when isLoading is true
            return const CircularProgressIndicator();
          }

          // Main UI content
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await controller.pickImageWithLocation();
                  if (controller.pickedImage.value != null) {
                    // Open the popup dialog to display the image after capturing
                    showDialog(
                      context: context,
                      builder: (_) {
                        return Obx(() {
                          return AlertDialog(
                            title: const Text('Captured Image with Lat/Long'),
                            content: IntrinsicHeight(
                              // Use IntrinsicHeight to force layout constraints
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Add padding or container to better format the lat/long area
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        controller.latLong.value,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    // Constrain the image size to avoid layout issues
                                    FittedBox(
                                      // Wrap image in FittedBox to handle sizing
                                      child: controller.pickedImage.value != null
                                          ? Image.file(
                                        controller.pickedImage.value!,
                                        width: MediaQuery.of(context).size.width * 0.8,
                                        height: 250, // Give the image a fixed height
                                        fit: BoxFit.contain,
                                      )
                                          : const Text('No image selected'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Close'),
                              ),
                            ],
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
                  controller.pickedImage.value!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                )
                    : const Text('No image selected');
              }),
            ],
          );
        }),
      ),
    );
  }
}
