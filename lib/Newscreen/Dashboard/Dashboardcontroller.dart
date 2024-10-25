import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Login/Login.dart';
import '../jsondashboard/model.dart';
import '../jsondashboard/service.dart';

class ListTankController extends GetxController {
  var tankList = <Tank>[].obs;   // Observable list of Tank model to display tanks
  var isLoading = true.obs;       // Observable for loading state
  var errorMessage = ''.obs;      // Observable for error messages

  final TankService tankService = TankService();  // Instance of the service to fetch tank data
  final box = GetStorage();  // Instance of GetStorage to access stored data

  // Fetch tanks from API and handle response based on the logged-in user
  Future<void> fetchTanks() async {
    isLoading(true);  // Start loading
    errorMessage('');  // Clear any existing error messages

    // Read the stored username for dynamic fetching
    String? username = box.read('username');

    if (username == null) {
      errorMessage('User not found. Please login again.');
      isLoading(false);
      return;
    }

    try {
      // Pass username to the service for user-specific data
      TankDataResponse? tankDataResponse = await tankService.fetchTanks(username);

      if (tankDataResponse != null) {
        tankList.assignAll(tankDataResponse.data);  // Populate tankList with real data
      } else {
        errorMessage('Failed to fetch data from API');
      }
    } catch (e) {
      // Handle exceptions and set an error message
      errorMessage('An error occurred: $e');
    } finally {
      isLoading(false);  // Stop loading after the data is fetched or an error occurs
    }
  }

  @override
  void onInit() {
    fetchTanks();  // Load initial data from the API when the controller initializes
    super.onInit();
  }

  // Logout function for managing user session
  void logout() {
    box.remove('isLoggedIn');  // Clear login data from storage
    box.remove('username');     // Clear username
    Get.offAll(() => LoginScreen());    // Navigate to login screen
  }
}
