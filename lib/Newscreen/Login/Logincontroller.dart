import 'dart:convert'; // Import for JSON decoding
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../Dashboard/Dashboard.dart'; // Import your CleaningCalendar page

class LogController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var isPasswordVisible = false.obs;
  final box = GetStorage();
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    print('Login Called');
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

    print("Login Data: $data");

    final url = Uri.parse('http://devftp.itank.io/water/iNeer/api/icleanApi/loginValidation.php');

    try {
      final response = await http.post(url, body: data);

      print("API Response: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body); // Assuming the response is in JSON format

        if (responseData['status'] == 'success') {
          Get.snackbar(
            'Login Success',
            'Welcome back!',
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 1),
          );

          // Ensure the route name here matches the one in your route setup
          Get.toNamed('/CleaningCalendar');
        } else {
          Get.snackbar(
            'Invalid',
            'Enter correct username and password',
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 1),
          );
          errorMessage.value = responseData['message'] ?? 'Login failed';
        }
      } else {
        errorMessage.value = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error connecting to the server';
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
