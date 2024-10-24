// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'Cameracontroller.dart';
//
// class ImageCaptureScreen extends StatelessWidget {
//   final ImageController controller = Get.put(ImageController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Kutta palayam',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.green,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Obx(
//             () => Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildSectionWithUpload(context, 'Before', controller.beforeImage, controller),
//                   const SizedBox(height: 150),
//                   _buildSectionWithUpload(context, 'During', controller.duringImage, controller),
//                   const SizedBox(height: 150),
//                   _buildSectionWithUpload(context, 'After', controller.afterImage, controller),
//                 ],
//               ),
//             ),
//             if (controller.isLoading.value)
//               const Center(
//                 child: CircularProgressIndicator(), // Loading spinner
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionWithUpload(BuildContext context, String section, Rx<File?> imageFile, ImageController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           section,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           children: [
//             _buildImageSection(context, section.toLowerCase(), imageFile, controller),
//             const SizedBox(width: 10),
//             IconButton(
//               icon: const Icon(Icons.upload_file, color: Colors.green),
//               onPressed: () => controller.pickImageWithLocation(section.toLowerCase()),
//               iconSize: 30, // Adjust the size of the icon
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildImageSection(BuildContext context, String section, Rx<File?> imageFile, ImageController controller) {
//     return GestureDetector(
//       onLongPress: () {
//         if (imageFile.value != null) {
//           _showImageModal(context, imageFile.value!, controller); // Pass the controller for download option
//         }
//       },
//       child: Container(
//         width: 100, // Adjust size accordingly
//         height: 100,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.green),
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: imageFile.value == null
//             ? const Icon(
//           Icons.add_a_photo,
//           size: 50,
//           color: Colors.green,
//         )
//             : ClipRRect(
//           borderRadius: BorderRadius.circular(8.0),
//           child: Image.file(
//             imageFile.value!,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) {
//               return const Icon(
//                 Icons.error,
//                 color: Colors.red,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showImageModal(BuildContext context, File image, ImageController controller) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           insetPadding: EdgeInsets.zero, // Ensures the dialog takes full screen space
//           backgroundColor: Colors.black, // Black background for fullscreen image
//           child: Stack(
//             children: [
//               Center(
//                 child: Image.file(
//                   image,
//                   fit: BoxFit.contain, // Adjusts the image to fit within the screen
//                 ),
//               ),
//               Positioned(
//                 top: 20,
//                 right: 20,
//                 child: IconButton(
//                   icon: const Icon(Icons.close, color: Colors.white, size: 30),
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Close the dialog
//                   },
//                 ),
//               ),
//               Positioned(
//                 bottom: 20,
//                 right: 20,
//                 child: IconButton(
//                   icon: const Icon(Icons.download, color: Colors.white, size: 30),
//                   onPressed: () async {
//                     await controller.downloadImage(image); // Download the image
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Image downloaded successfully')),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
