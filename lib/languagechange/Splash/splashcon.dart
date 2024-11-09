import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../dashboard/dashUI.dart';
import '../login/loginUI.dart';
class fistcontroller extends GetxController {
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }
  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    bool isLoggedIn = box.read('isLoggedIn') ?? false;
    if (isLoggedIn) {
      String? username = box.read('username');
      Get.offAll(() => CleanCalendar(username: username, ));  // Pass username to home screen
    } else {
      Get.offAll(() => LogScreen());
    }
  }
}
