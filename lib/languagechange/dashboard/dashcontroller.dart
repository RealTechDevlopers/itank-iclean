import 'dart:async';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Newscreen/jsondashboard/model.dart';
import '../../Newscreen/jsondashboard/service.dart';
import '../login/loginUI.dart';
class ListController extends GetxController {
  var tankList = <Tank>[].obs; // Observable list of Tank model to display tanks
  var isLoading = true.obs; // Observable for loading state
  var errorMessage = ''.obs; // Observable for error messages
  // var selectedDropdownItem = 'Profile'.obs;
  var selectedLanguage = 'English'.obs;
  // var tankList = <Tank>[].obs; // Tank list will automatically update

  final TankService tankService = TankService(); // Instance of the service to fetch tank data
  final box = GetStorage(); // Instance of GetStorage to access stored data
  final List<Map<String, String>> languages = [
    {'name': 'English', 'locale': 'en_US'},
    {'name': 'Tamil', 'locale': 'ta_ES'},
    {'name': "Hindi",'locale':"hi_IN"}
  ];

  // void updateSelectedItem(String newItem) {
  //   selectedDropdownItem.value = newItem;
  // }

  // Helper method to compute adjusted days count


  void changeLanguage(String language) {
    selectedLanguage.value = language;
    // Locate locale from selected language
    String? localeCode = languages.firstWhere((lang) => lang['name'] == language)['locale'];
    if (localeCode != null) {
      var localeList = localeCode.split('_');
      Get.updateLocale(Locale(localeList[0], localeList[1]));
      // update();
    }
  }
  int computeDaysCountAfterClean(int? daysCountAfterClean) {
    if (daysCountAfterClean != null && daysCountAfterClean > 15) {
      return 15 - daysCountAfterClean; // Calculate negative if greater than 15
    }
    return daysCountAfterClean ?? 0; // Return original value or 0 if null
  }


  // Fetch tanks from API and handle response based on the logged-in user
  Future<void> fetchTanks() async {
    isLoading(true); // Start loading
    errorMessage(''); // Clear any existing error messages

    // Read the stored username for dynamic fetching
    String? username = box.read('username');

    if (username == null) {
      errorMessage('User not found. Please login again.');
      isLoading(false);
      return;
    }

    try {
      TankDataResponse? tankDataResponse = await tankService.fetchTanks(username);
      if (tankDataResponse != null) {
        // Map the tank data to include computed days count
        tankList.assignAll(
          tankDataResponse.data.map((tank) {
            tank.displaydayscount = computeDaysCountAfterClean(tank.daysCountAfterClean);
            return tank;
          }).toList(),
        );
      } else {
        errorMessage('Failed to fetch data from API');
      }
    } catch (e) {
      errorMessage('An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }


  @override
  void onInit() {
    fetchTanks(); // Load initial data from the API when the controller initializes
    super.onInit();
    Timer.periodic(Duration(days: 1), (timer) {
      fetchTanks(); // Re-fetch data daily to update daysRemaining values
    });
    final storedUsername = box.read('username');
    // Logout function for managing user session
    void logout() {
      box.remove('isLoggedIn'); // Clear login data from storage
      box.remove('username'); // Clear username
      Get.offAll(() => LogScreen()); // Navigate to login screen
    }
  }
}
