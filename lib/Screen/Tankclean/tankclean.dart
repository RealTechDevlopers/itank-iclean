// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../Screens/Tank clean/tank clean_controller.dart';
// class TankScreen extends StatelessWidget {
//   final TankScreenController controller = Get.put(TankScreenController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tank-4', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.green,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text(
//                 'Before Clean',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//               const SizedBox(height: 100),
//               GestureDetector(
//                 onTap: () {
//                   controller.onBeforeImageTap();
//                 },
//                 child: GetBuilder<TankScreenController>(
//                   builder: (controller) {
//                     return controller.beforeImage != null
//                         ? Image.file(
//                             controller.beforeImage!,
//                             height: 100,
//                             width: 100,
//                           )
//                         : Image.asset(
//                             'assets/Images/camera.png',
//                             height: 100,
//                             width: 100,
//                           );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 170),
//               const Text(
//                 'After Clean',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//               const SizedBox(height: 120),
//               GestureDetector(
//                 onTap: () {
//                   controller.onAfterImageTap();
//                 },
//                 child: GetBuilder<TankScreenController>(
//                   builder: (controller) {
//                     return controller.afterImage != null
//                         ? Image.file(
//                             controller.afterImage!,
//                             height: 100,
//                             width: 100,
//                           )
//                         : Image.asset(
//                             'assets/Images/camera.png',
//                             height: 100,
//                             width: 100,
//                           );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
