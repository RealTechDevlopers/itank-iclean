import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Cameracontroller.dart';
class ImageCaptureScreen extends StatelessWidget {
  final ImageController controller = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kutta palayam'),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Before Section
            const Text(
              'Before',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Obx(() => GestureDetector(
                onTap: () => controller.pickImageFromCamera('before'),
                child: controller.beforeImage.value == null
                    ? Icon(Icons.add_a_photo, size: 50, color: Colors.green)
                    : CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(controller.beforeImage.value!),
                  // Fallback to default if FileImage fails
                  onBackgroundImageError: (error, stackTrace) {
                    print('Error loading image: $error');
                  },
                ),
              )),
            ),
            const SizedBox(height: 30),

            // During Section
            const Text(
              'During',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Obx(() => GestureDetector(
                onTap: () => controller.pickImageFromCamera('during'),
                child: controller.duringImage.value == null
                    ? Icon(Icons.add_a_photo, size: 50, color: Colors.green)
                    : CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(controller.duringImage.value!),
                  onBackgroundImageError: (error, stackTrace) {
                    print('Error loading image: $error');
                  },
                ),
              )),
            ),
            const SizedBox(height: 30),
            const Text(
              'After',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Obx(() => GestureDetector(
                onTap: () => controller.pickImageFromCamera('after'),
                child: controller.afterImage.value == null
                    ? Icon(Icons.add_a_photo, size: 50, color: Colors.green)
                    : CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(controller.afterImage.value!),
                  onBackgroundImageError: (error, stackTrace) {
                    print('Error loading image: $error');
                  },
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

