import 'dart:convert'; // Import for JSON decoding
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../dashboard/dashUI.dart';

class LogiController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var isPasswordVisible = false.obs;
  final box = GetStorage(); // Initialize GetStorage
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    if (username.isEmpty || password.isEmpty) {
      errorMessage.value = 'Please enter both username and password';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    Map<String, String> data = {
      'username': username.value,
      'password': password.value,
    };

    final url = Uri.parse('http://devftp.itank.io/water/ineer/api/icleanApi/loginValidation.php');

    try {
      final response = await http.post(url, body: data);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
          // Store the username and login status in local storage
          box.write('isLoggedIn', true);
          box.write('username', username.value); // Store the logged-in user's name

          Get.snackbar(
            'Login Success',
            'Welcome back, ${username.value}!',
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 1),
          );

          // Navigate to Home Screen
          //Get.offAllNamed('/CleaningCalendar');
          Get.offAll(() => CleanCalendar(username: username.value));
        } else {
          errorMessage.value = responseData['message'] ?? 'Login failed';
          Get.snackbar(
            'Invalid',
            'Enter correct username and password',
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 1),
          );
        }
      } else {
        errorMessage.value = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error connecting to the server';
    } finally {
      isLoading.value = false;
    }
  }
}
