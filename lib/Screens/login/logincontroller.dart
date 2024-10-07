import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'otp_scr.dart';
class LoginController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  void requestOtp() {
    String phone = phoneController.text.trim();
    if (phone.isEmpty
     ||
         !RegExp(r'^\d{10}$').hasMatch(phone)
    ) {
      Get.snackbar(
        'Error',
        'Please enter a valid 10-digit mobile number.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.to(() => OtpScr(phoneNumber: phone));
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
