import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Newscreen/jsondashboard/model.dart';
import 'camcontroller.dart';
class ImageScreen extends StatelessWidget {
  final Tank tank;
  final Imagecontroller controller = Get.put(Imagecontroller());
  ImageScreen({Key? key, required this.tank}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tank.tankName,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Obx(() => IconButton(
                icon: const Icon(Icons.add, size: 30),
                onPressed: controller.isActionEnabled.value
                    ? () {
                        controller.resetImages();
                        Get.snackbar("Reset", "You can now upload new images.",
                            duration: Duration(seconds: 1));
                      }
                    : null, // Disabled if action not enabled
              )),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          return Obx(
            () => SingleChildScrollView(
              child: Stack(children: [
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // "Before" Section
                      Card(
                        color: Colors.white,
                        margin:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: _buildSectionWithUpload(
                            context,
                            'before',
                            controller.beforeImage,
                            controller,
                            tank,
                            screenWidth,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // "During" Section
                      Card(
                        color: Colors.white,
                        margin:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: controller.beforeImage.value != null ||
                                  tank.beforeImg != ""
                              ? _buildSectionWithUpload(
                                  context,
                                  'during',
                                  controller.duringImage,
                                  controller,
                                  tank,
                                  screenWidth,
                                )
                              : _buildNoImage(
                                  context, 'during', screenWidth, screenHeight),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // "After" Section
                      Card(
                        color: Colors.white,
                        margin:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: controller.duringImage.value != null ||
                                  tank.duringImg != ""
                              ? _buildSectionWithUpload(
                                  context,
                                  'after',
                                  controller.afterImage,
                                  controller,
                                  tank,
                                  screenWidth,
                                )
                              : _buildNoImage(
                                  context, 'after', screenWidth, screenHeight),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // Upload Progress Indicator
                      StreamBuilder<double>(
                        stream: controller.uploadProgressStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data! > 0) {
                            return Column(
                              children: [
                                Text(
                                    "Uploading: ${snapshot.data!.toStringAsFixed(0)}%"),
                                CircularProgressIndicator(
                                  value: snapshot.data! /
                                      100, // Scale percentage to 0-1
                                  backgroundColor: Colors.green,
                                  color: Colors.green,
                                ),
                              ],
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                if (controller.isLoading.value)
                  Positioned.fill(
                    child: Container(
                    //  color: Colors.black.withOpacity(0.5), // Optional dim background
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionWithUpload(
      BuildContext context,
      String section,
      Rx<File?> imageFile,
      Imagecontroller controller,
      Tank tank,
      double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.tr,
          style: TextStyle(
              fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: screenWidth * 0.03),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildImageSection(context, section.toLowerCase(), imageFile,
                controller, tank, screenWidth),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green
                      .withOpacity(0.1), // Set a light background color
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: TextButton.icon(
                  onPressed: () {
                    if (imageFile.value != null) {
                      String tankType = section == "before"
                          ? "beforeImg"
                          : section == "during"
                              ? "duringImg"
                              : "afterImg";
                      log("Selection : $section");
                      controller.uploadImage(
                          imageFile.value!, tank.tankName, tankType, tank);
                    } else {
                      Get.snackbar("Error", "Please capture an image first",
                          duration: const Duration(seconds: 1));
                    }
                  },
                  icon: Icon(
                    Icons.upload_file,
                    color: Colors.green,
                    size: screenWidth * 0.08,
                  ),
                  label: Text(
                    'upload'.tr,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: screenWidth * 0.027,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageSection(
      BuildContext context,
      String section,
      Rx<File?> imageFile,
      Imagecontroller controller,
      Tank tank,
      double screenWidth) {
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
          width: screenWidth * 0.4,
          height: screenWidth * 0.4,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9.0),
            child: useNetworkImage
                ? Image.network(
                    imgUrl.replaceAll("https", "http"),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  )
                : imageFile.value == null
                    ? Icon(
                        Icons.camera_alt,
                        size: screenWidth * 0.15,
                        color: Colors.green,
                      )
                    : Image.file(
                        imageFile.value!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
          ),
        ));
  }

  Widget _buildNoImage(BuildContext context, String section, double screenWidth,
      double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.tr,
          style: TextStyle(
              fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: screenWidth * 0.03),
        Row(
          children: [
            Container(
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                Icons.camera_alt,
                size: screenWidth * 0.15,
                color: Colors.grey,
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey
                      .withOpacity(0.1), // Set a light background color
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.upload_file,
                    color: Colors.grey,
                    size: screenWidth * 0.08,
                  ),
                  label: Text(
                    'upload'.tr,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: screenWidth * 0.027,
                    ),
                  ),
                ),
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
                  fit: BoxFit.cover,
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
    // Log the URL to confirm it's correct
    log("Showing modal for image URL: $imgUrl");

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
                  // .replaceAll("https", "http"),
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    log("Failed to load image: $error");
                    return Image.network(
                      imgUrl.replaceAll("https", "http"),
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                      errorBuilder: (context, error, stackTrace) {
                        log("Failed to load image: $error");
                        return Image.network(
                          imgUrl.replaceAll("https", "http"),
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            log("Failed to load image: $error");
                            return const Icon(
                              Icons.error,
                              color: Colors.red,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Positioned(
                top: 10,
                right: 8,
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
