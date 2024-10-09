import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Login/Login.dart';
class DashboardController extends GetxController {
  final box = GetStorage();
  void logout() {
    box.remove('isLoggedIn');
    Get.offAll(() => LogScreen());
  }
}
