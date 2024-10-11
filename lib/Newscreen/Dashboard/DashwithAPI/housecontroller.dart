// tank_controller.dart
import 'package:get/get.dart';

import 'Service.dart';
import 'housemodel.dart';


class HouseController extends GetxController {
  var tankList = <TankModel>[].obs;  // Observable list to store the tanks
  var isLoading = true.obs;  // Loading state

  // Function to fetch tanks with uname and flag
  void fetchTanks(String uname, String flag) async {
    try {
      isLoading(true);  // Show loading
      var tanks = await TankService.fetchTanks(uname, flag);  // Fetch tanks
      if (tanks.isNotEmpty) {
        tankList.value = tanks;  // Update the list with fetched data
      }
    } catch (e) {
      print('Error fetching tanks: $e');
    } finally {
      isLoading(false);  // Hide loading
    }
  }
}
