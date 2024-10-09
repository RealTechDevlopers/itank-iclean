// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import '../Dashboard/Home.dart';
// import 'login_scr.dart';
// class OtpController extends GetxController {
//   var otpCode = ''.obs;
//   void updateOtp(String code) {
//     otpCode.value = code;
//   }
//   void navigateToLoginScr(){
//     Get.to(LoginScr());
//   }
//   void validateOtp(BuildContext context) {
//     if (otpCode.value.length != 4) {
//       Get.snackbar(
//         'Error',
//         'Please enter a valid 4-digit OTP.',
//         backgroundColor: Colors.redAccent,
//         colorText: Colors.white,
//         duration: Duration(seconds: 1),
//       );
//     } else {
//       print('Validating OTP: ${otpCode.value}');
//       Get.snackbar(
//         'Success',
//         'OTP is valid!',
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//         duration: Duration(seconds: 1),
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       Get.offAll(() => Home());
//     }
//   }
// }
