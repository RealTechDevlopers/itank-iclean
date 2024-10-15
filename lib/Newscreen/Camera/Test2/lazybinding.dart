import 'package:get/get.dart';
import 'camcontroller.dart';
class CaptureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CaptureController>(() => CaptureController());
  }
}
