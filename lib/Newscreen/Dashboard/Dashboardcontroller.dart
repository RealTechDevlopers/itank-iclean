import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Login/Login.dart';
import '../Report/test/Testreport.dart';
import 'Model.dart';
class TankController extends GetxController {
  var tankList = <TankStatus>[].obs;
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    loadTankData();
  }
  void loadTankData() {
    var data = [
      TankStatus(name: "Basuvapatti", dueDays: 8, status: ["Before", "During", "After"], isLocationAvailable: true),
      TankStatus(name: "Basuvapatti", dueDays: 2, status: ["Before", "During", "After"], isLocationAvailable: true),
      TankStatus(name: "Kumaravalasu", dueDays: 1, status: ["Before", "During", "After"], isLocationAvailable: true),
      TankStatus(name: "Kuppichi palayam", dueDays: 0, status: ["Before", "During", "After"], isLocationAvailable: true),
      TankStatus(name: "Kutta palayam", dueDays: -4, status: ["Before", "During", "After"], isLocationAvailable: true),
      TankStatus(name: "Vadamugam vellode", dueDays: 12, status: ["Before", "During", "After"], isLocationAvailable: true),
    ];
    tankList.assignAll(data);
  }
  void logout() {
    box.remove('isLoggedIn');
    Get.offAll(() => LogScreen());
  }
  void NavigateTOreport(){
    Get.to(repo());
  }

}
