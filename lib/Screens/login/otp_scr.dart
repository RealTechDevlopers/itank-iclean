// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pinput/pinput.dart';
// import '../Dashboard/Home_controller.dart';
// import 'otp_scr_controller.dart';
// class OtpScr extends StatelessWidget {
//   final box = GetStorage();
//   final String phoneNumber;
//    OtpScr({Key? key, required this.phoneNumber}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final defaultpinTheme = PinTheme(
//         width: 50,
//         height: 60,
//         textStyle: const TextStyle(
//           fontSize: 22,
//           color: Colors.black,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(5),
//           border: Border.all(color: Colors.transparent),
//         )
//     );
//     final OtpController otpController = Get.put(OtpController());
//     final Home_Controller controller = Get.put(Home_Controller());
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: (){
//             controller.navigateToLogin();
//           }
//         ),
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.blue.shade900, Colors.blue.shade300],
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 50),
//               Text(
//                 'iTank Clean',
//                 style: GoogleFonts.averiaSerifLibre(
//                   color: Colors.white,
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Image.asset(
//                 'assets/Images/bro.png',
//               ),
//               const SizedBox(height: 40),
//               Text(
//                 "Enter OTP for $phoneNumber",
//                 style: GoogleFonts.averiaSerifLibre(
//                   color: Colors.white,
//                   fontSize: 27,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//                SizedBox(height: 30),
//               Pinput(
//                 length: 4,
//                 defaultPinTheme: defaultpinTheme,
//                 onChanged: (value){
//                   otpController.updateOtp(value);
//                 },
//               ),
//               // OtpTextField(
//               //   numberOfFields: 4,
//               //   borderColor: const Color(0xFF512DA8),
//               //   showFieldAsBox: true,
//               //   onSubmit: (String verificationCode) {
//               //     otpController.updateOtp(verificationCode);
//               //   },
//               // ),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () {
//                   otpController.validateOtp(context);
//                   box.write('isLoggedIn', true);
//                 //  Get.offAll(LoginScr());
//                  //  controller.navigateToLogin();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   elevation: 10,
//                   foregroundColor: Colors.blue,
//                   backgroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 child: const Text(
//                   'Login',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//               const SizedBox(height: 50),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }