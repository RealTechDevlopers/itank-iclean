import 'package:get/get.dart';

class UserCreationController extends GetxController {
  var isAdminVisible = true.obs;  // Initially, Admin creation is visible.
  var isPresidentVisible = false.obs;

  void showAdminFields() {
    isAdminVisible.value = true;
    isPresidentVisible.value = false;
  }

  void showPresidentFields() {
    isAdminVisible.value = false;
    isPresidentVisible.value = true;
  }
}
