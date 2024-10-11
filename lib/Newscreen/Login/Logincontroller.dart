import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../Dashboard/Dashboard.dart';
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
    print('Called');
    if (username.isEmpty || password.isEmpty) {
      errorMessage.value = 'Please enter both username and password';
      return;
    }
    isLoading.value = true;
    errorMessage.value = '';
    Map<String, String> data = {
      'uname': "${username.string}",
      'pass': password.string
    };
    print("login : ${data}");
    final url = Uri.parse('https://www.itank.io/api/user_login.php');
    final response = await http.post(
      url,
      body: data,
    );
    print("object response :  ${response.body}");
    if (response.statusCode == 200) {
      final responseData = response.body;
      if (responseData == 'success') {
        Get.snackbar('Login Success', 'Welcome back!',colorText:Colors.white,
            snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green,duration: Duration(seconds: 1));
        Get.to(CleaningCalendar());
        //Get.offAllNamed(const Dssh() as String);
      } else {
        Get.snackbar('Invalid', 'Enter correct user name and password',colorText:Colors.white,
            snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red,duration: Duration(seconds:1));
        errorMessage.value = responseData ?? 'Login failed';
      }
    } else {
      errorMessage.value = 'Server error: ${response.statusCode}';
    }
    isLoading.value = false;
  }
}
