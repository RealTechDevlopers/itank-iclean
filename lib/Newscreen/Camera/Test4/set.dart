import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../jsondashboard/model.dart';
import 'setcontroller.dart';

class ImageapiScreen extends StatelessWidget {
  final String tankName;
  final Tank tank;
  final Imageapicontroller controller = Get.put(Imageapicontroller());

  ImageapiScreen({Key? key, required this.tankName, required this.tank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tankName,
          style: const TextStyle(color: Colors.white),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildSectionWithUpload(context, 'Before', controller.beforeImage, controller, tank),
                  const SizedBox(height: 100),
                  controller.beforeImage.value != null || tank.beforeImg != ""
                      ? _buildSectionWithUpload(context, 'During', controller.duringImage, controller, tank)
                      : _buildNoImage(context, 'During'),
                  const SizedBox(height: 100),
                  controller.duringImage.value != null || tank.duringImg != ""
                      ? _buildSectionWithUpload(context, 'After', controller.afterImage, controller, tank)
                      : _buildNoImage(context, 'After'),
                  const SizedBox(height: 30),
                  if (controller.uploadProgress > 0.0)
                    LinearProgressIndicator(value: controller.uploadProgress),
                ],
              ),
            ),
            if (controller.isLoading.value)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionWithUpload(
      BuildContext context, String section, Rx<File?> imageFile, Imageapicontroller controller, Tank tank) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildImageSection(context, section.toLowerCase(), imageFile, controller, tank),
            const SizedBox(width: 10),
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.upload_file, color: Colors.green),
                onPressed: () {
                  if (imageFile.value != null) {
                    String tankType = "";
                    if (section == "Before") {
                      tankType = "beforeImg";
                    } else if (section == "During") {
                      tankType = "duringImg";
                    } else {
                      tankType = "afterImg";
                    }
                    log("Selection : $section");
                    controller.uploadImage(imageFile.value!, tankName, tankType, tank);
                  } else {
                    Get.snackbar("Error", "Please capture an image first", duration: const Duration(seconds: 1));
                  }
                },
                iconSize: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageSection(
      BuildContext context, String section, Rx<File?> imageFile, Imageapicontroller controller, Tank tank) {
    String imgUrl = "";
    bool useNetworkImage = false;

    if (section == "before" && tank.beforeImg != "") {
      imgUrl = jsonDecode(tank.beforeImg)['url'];
      useNetworkImage = true;
    } else if (section == "during" && tank.duringImg != "") {
      imgUrl = jsonDecode(tank.duringImg)['url'];
      useNetworkImage = true;
    } else if (section == "after" && tank.afterImg != "") {
      imgUrl = jsonDecode(tank.afterImg)['url'];
      useNetworkImage = true;
    }

    return GestureDetector(
      onTap: () {
        controller.pickImageWithLocation(section);
      },
      onLongPress: () {
        if (useNetworkImage) {
          _showImageModalURL(context, imgUrl);
        } else if (imageFile.value != null) {
          _showImageModal(context, imageFile.value!);
        }
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: useNetworkImage
            ? Image.network(
          imgUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.error,
            color: Colors.red,
          ),
        )
            : imageFile.value == null
            ? const Icon(
          Icons.camera_alt,
          size: 50,
          color: Colors.green,
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.file(
            imageFile.value!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoImage(BuildContext context, String section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 50,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.upload_file, color: Colors.grey),
                onPressed: null,
                iconSize: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showImageModal(BuildContext context, File image) {
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

  void _showImageModalURL(BuildContext context, String imgUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.black,
          child: Stack(
            children: [
              Center(
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
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
