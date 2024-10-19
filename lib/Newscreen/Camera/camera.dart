import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Cameracontroller.dart';
class ImageCaptureScreen extends StatelessWidget {
  final ImageController controller = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kutta palayam',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Before',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Obx(
                    () => GestureDetector(
                  onTap: () => controller.pickImageFromCamera('before'),
                  onLongPress: () {
                    if (controller.beforeImage.value != null) {
                      _showImageModal(context, controller.beforeImage.value!);
                    }
                  },
                  child: Container(
                    width: 100, // Adjust size accordingly
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: controller.beforeImage.value == null
                        ? const Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.green,
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        controller.beforeImage.value!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.error,
                            color: Colors.red,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 150),
            const Text(
              'During',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Obx(
                    () => GestureDetector(
                  onTap: () => controller.pickImageFromCamera('during'),
                  onLongPress: () {
                    if (controller.duringImage.value != null) {
                      _showImageModal(context, controller.duringImage.value!);
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: controller.duringImage.value == null
                        ? const Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.green,
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        controller.duringImage.value!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.error,
                            color: Colors.red,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 150),
            const Text(
              'After',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Obx(
                    () => GestureDetector(
                  onTap: () => controller.pickImageFromCamera('after'),
                  onLongPress: () {
                    if (controller.afterImage.value != null) {
                      _showImageModal(context, controller.afterImage.value!);
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: controller.afterImage.value == null
                        ? const Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.green,
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        controller.afterImage.value!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.error,
                            color: Colors.red,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showImageModal(BuildContext context, File image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.file(image, fit: BoxFit.contain),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}