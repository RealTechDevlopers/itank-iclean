import 'package:get/get.dart';
import 'Service.dart';
import 'housemodel.dart';
class HouseController extends GetxController {
  var tankList = <TankModel>[].obs;
  var isLoading = true.obs;
  void fetchTanks(String uname, String flag) async {
    try {
      isLoading(true);
      var tanks = await TankService.fetchTanks(uname, flag);
      if (tanks.isNotEmpty) {
        tankList.value = tanks;
      }
    } catch (e) {
      print('Error fetching tanks: $e');
    } finally {
      isLoading(false);
    }
  }
}
