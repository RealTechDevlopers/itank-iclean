import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Dashboard/Home.dart';
import '../login/login_scr.dart';
class FirstController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }
  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    final box = GetStorage();
    bool isLoggedIn = box.read('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Get.offAll(() =>  Home());
    } else {
      Get.offAll(() => LoginScr());
    }
  }
}
