// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../Dashboard/Home.dart';
// import 'admin_creation_controller.dart';
// import 'package:image_picker/image_picker.dart';
//
// class Adminscreen extends StatelessWidget {
//   final _nameController = TextEditingController();
//   final _mobileController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final AdminCreationControllerController controller = Get.put(AdminCreationControllerController());
//
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Get.to(const Home());
//           },
//         ),
//       ),
//       body: Center(
//         child: Container(
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [Color(0xFF1565C0), Color(0xFF64B5F6)],
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 80),
//               Text(
//                 "Register",
//                 style: GoogleFonts.averiaSerifLibre(
//                   color: Colors.white,
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               GestureDetector(
//                 onTap: controller.pickImageFromCamera,
//                 child: Obx(() => CircleAvatar(
//                   radius: 40,
//                   backgroundColor: Colors.white.withOpacity(0.3),
//                   child: controller.selectedImage.value == null
//                       ? const Icon(
//                     Icons.camera_alt_outlined,
//                     size: 50,
//                     color: Colors.white,
//                   )
//                       : ClipOval(
//                     child: Image.file(
//                       controller.selectedImage.value!,
//                       width: 80,
//                       height: 80,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 )),
//               ),
//               const SizedBox(height: 30),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: TextField(
//                   controller: _nameController,
//                   keyboardType: TextInputType.name,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     hintText: 'Person Name',
//                     prefixIcon: const Icon(Icons.person),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: TextField(
//                   controller: _mobileController,
//                   keyboardType: TextInputType.phone,
//                   maxLength: 10,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     hintText: 'Mobile Number',
//                     counterText: '',
//                     prefixIcon: const Icon(Icons.phone_android),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed: () {
//                   controller.registerUser(_nameController.text, _mobileController.text);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF4E4E4E),
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 child: Text(
//                   "Register",
//                   style: GoogleFonts.averiaSerifLibre(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
