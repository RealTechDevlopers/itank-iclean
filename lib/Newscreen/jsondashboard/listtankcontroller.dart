import 'package:get/get.dart';
import 'service.dart';
import 'model.dart';

class ListTankController extends GetxController {  // Use PascalCase here
  var tankList = <Tank>[].obs;  // Observable list of Tank model
  var isLoading = true.obs;      // Observable for loading state
  var errorMessage = ''.obs;     // Observable for error messages

  final TankService tankService = TankService();  // Instance of the service

  Future<void> fetchTanks() async {
    isLoading(true);  // Start loading
    errorMessage('');  // Clear any existing error messages

    try {
      // Fetch data from the service
      TankDataResponse? tankDataResponse = await tankService.fetchTanks('pktr');

      if (tankDataResponse != null) {
        tankList.addAll(tankDataResponse.data);  // Add the Tank objects to the list
      } else {
        errorMessage('Failed to fetch data from API');
      }
    } catch (e) {
      // Handle any exceptions and set an error message
      errorMessage('An error occurred: $e');
    } finally {
      isLoading(false);  // Stop loading after the data is fetched or in case of an error
    }
  }

  @override
  void onInit() {
    fetchTanks();  // Load initial data
    super.onInit();
  }
}
