import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iclean/Newscreen/Camera/Test4/setcontroller.dart';
class ImageapiScreen extends StatelessWidget {
  final Imageapicontroller controller = Get.put(Imageapicontroller());
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

                  // Section to display the 'Before' image capture and upload
                  _buildSectionWithUpload(context, 'Before', controller.beforeImage, controller),

                  const SizedBox(height: 20),

                  // Display upload progress (if any)
                  if (controller.uploadProgress > 0.0)
                    LinearProgressIndicator(value: controller.uploadProgress),

                  const SizedBox(height: 30),
                ],
              ),
            ),
            if (controller.isLoading.value)
              const Center(
                child: CircularProgressIndicator(), // Loading spinner during capture/upload
              ),
          ],
        ),
      ),
    );
  }

  // Widget for image capture and upload section
  Widget _buildSectionWithUpload(BuildContext context, String section, Rx<File?> imageFile, Imageapicontroller controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            // Camera Icon to open the camera and capture image
            _buildImageSection(context, section.toLowerCase(), imageFile, controller),
            const SizedBox(width: 40),
            // Upload Icon to upload the captured image
            IconButton(
              icon: const Icon(Icons.upload_file, color: Colors.green),
              onPressed: () {
                if (controller.beforeImage.value != null) {
                  String tankName = 'Tank001';
                  String imei = '123456789012345';
                  controller.uploadImage(controller.beforeImage.value!,tankName,imei); // Upload the captured image
                } else {
                  Get.snackbar("Error", "Please capture an image first");
                }
              },
              iconSize: 30,
            ),
          ],
        ),
      ],
    );
  }

  // Widget to display the captured image or camera icon
  Widget _buildImageSection(BuildContext context, String section, Rx<File?> imageFile, Imageapicontroller controller) {
    return GestureDetector(
      onTap: () {
        controller.pickImageWithLocation(section); // Open camera
      },
      onLongPress: () {
        if (imageFile.value != null) {
          _showImageModal(context, imageFile.value!, controller); // Preview image in full screen
        }
      },

      child: Container(
        width: 150, // Adjust size accordingly
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: imageFile.value == null
            ? const Icon(
          Icons.camera_alt, // Camera icon
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
    );
  }

  // Function to show full-screen preview of the image
  void _showImageModal(BuildContext context, File image, Imageapicontroller controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.black,
          child: Stack(
            children: [
              Center(
                child: Image.file(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
