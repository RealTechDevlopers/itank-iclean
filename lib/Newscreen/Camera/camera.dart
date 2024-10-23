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
      body: Obx(
            () => Stack(
          children: [
            Padding(
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
                  _buildImageSection(
                      context, 'before', controller.beforeImage, controller),
                  const SizedBox(height: 150),
                  const Text(
                    'During',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildImageSection(
                      context, 'during', controller.duringImage, controller),
                  const SizedBox(height: 150),
                  const Text(
                    'After',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildImageSection(
                      context, 'after', controller.afterImage, controller),
                ],
              ),
            ),
            if (controller.isLoading.value)
              const Center(
                child: CircularProgressIndicator(), // Loading spinner
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, String section,
      Rx<File?> imageFile, ImageController controller) {
    return Center(
      child: GestureDetector(
        onTap: () => controller.pickImageWithLocation(section),
        onLongPress: () {
          if (imageFile.value != null) {
            _showImageModal(context, imageFile.value!);
          }
        },
        child: Container(
          width: 100, // Adjust size accordingly
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: imageFile.value == null
              ? const Icon(
            Icons.add_a_photo,
            size: 50,
            color: Colors.green,
          )
              : ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.file(
              imageFile.value!,
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
