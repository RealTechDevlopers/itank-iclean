import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Dashboard/Dashboard.dart';
import '../Login/Login.dart';

class FirstController extends GetxController {
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
      Get.offAll(() => CleaningCalendar(username: username));  // Pass username to home screen
    } else {
      Get.offAll(() => LoginScreen());
    }
  }
}
