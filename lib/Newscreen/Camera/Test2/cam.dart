// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'camcontroller.dart';
// class CaptureView extends StatelessWidget {
//   final CaptureController controller = Get.put(CaptureController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Capture Image with Location'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Obx(() {
//               return controller.image.value == null
//                   ? const Text('No image captured.')
//                   : Image.file(controller.image.value!, height: 300, width: 300);
//             }),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => controller.captureImage(),
//               child: const Text('Capture Image with Location'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
