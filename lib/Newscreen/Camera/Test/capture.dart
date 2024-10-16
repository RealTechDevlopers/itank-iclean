import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'capturecontroller.dart';

class ImageCaptuScreen extends StatelessWidget {
  final ImagegeoController controller = Get.put(ImagegeoController());

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageSection(context, 'Before', controller.beforeImage,
                  controller.beforeGeoTag, 'before'),
              const SizedBox(height: 150),
              _buildImageSection(context, 'During', controller.duringImage,
                  controller.duringGeoTag, 'during'),
              const SizedBox(height: 150),
              _buildImageSection(context, 'After', controller.afterImage,
                  controller.afterGeoTag, 'after'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, String label,
      Rx<File?> imageFile, Rxn<Map<String, double>> geoTag, String section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Center(
          child: Obx(
            () => GestureDetector(
              onTap: () => controller.pickImageFromCamera(section),
              onLongPress: () {
                if (imageFile.value != null) {
                  _showImageModal(context, imageFile.value!, geoTag);
                }
              },
              child: Container(
                width: 100,
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
          ),
        ),
        const SizedBox(height: 5),
        // Location display removed from here
      ],
    );
  }

  void _showImageModal(
      BuildContext context, File image, Rxn<Map<String, double>> geoTag) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Rounded corners
          ),
          elevation: 10, // Adds shadow to the dialog
          backgroundColor: Colors.white, // Background color for the modal
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  // Display the main image with rounded corners
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    child: Image.file(image, fit: BoxFit.contain),
                  ),

                  // Text overlay at the bottom of the image
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 90,
                      color: Colors.black.withOpacity(0.4), // Semi-transparent background
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align content across the row
                        crossAxisAlignment: CrossAxisAlignment.center, // Vertically center items
                        children: [
                          // Left side - location details (Latitude and Longitude)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (geoTag.value != null) ...[
                                Text(
                                  'Latitude: ${geoTag.value!['latitude']}',
                                  style: const TextStyle(fontSize: 12, color: Colors.white),
                                ),
                              //  const SizedBox(height: 5),
                                Text(
                                  'Longitude: ${geoTag.value!['longitude']}',
                                  style: const TextStyle(fontSize: 12, color: Colors.white),
                                ),
                              ] else
                                const Text(
                                  'Location data not available',
                                  style: TextStyle(fontSize: 12, color: Colors.grey,),
                                ),
                              Text('Name:Ramesh',style: TextStyle(color: Colors.white,fontSize: 12),),
                              Text('Phone:8754277347',style: TextStyle(color: Colors.white,fontSize: 12),)
                            ],
                          ),
                          SizedBox(width: 20,),
                          Container(
                            width: 100,  // Set a fixed width
                            height: 100, // Set a fixed height
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/Images/RTS.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Close button
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Rounded button
                    ),
                    backgroundColor: Colors.green, // Button color
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Close',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

  }
}
