import 'package:get/get.dart';
import 'package:iclean/Newscreen/jsondashboard/service.dart';

// import '../Dashboard/DashwithAPI/Service.dart';
import '../Dashboard/DashwithAPI/housemodel.dart';
import 'model.dart';

class listtankController extends GetxController {
  var tankList = <Tank>[].obs;  // Observable list of Tank model
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var currentPage = 1;
  var hasMoreData = true.obs;

  final TankService tankService = TankService();  // Instance of the service

  Future<void> fetchTanks({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (hasMoreData.value && !isLoading.value) {
        currentPage++;
      } else {
        return;
      }
    } else {
      currentPage = 1;
      tankList.clear();  // Clear the list for fresh data on the first load
    }

    isLoading(true);
    errorMessage('');

    // Fetch data from the service
    // TankDataResponse tankDataResponse = await tankService.fetchTanks('pktr');
    TankDataResponse? tankDataResponse = await tankService.fetchTanks('pktr') ;

    if (tankDataResponse != null) {
      if (tankDataResponse.data.length < 10) {
        hasMoreData.value = false;  // No more data to load
      }

      tankList.addAll(tankDataResponse.data);  // Add the Tank objects to the list
    } else {
      errorMessage('Failed to fetch data from API');
    }

    isLoading(false);
  }

  @override
  void onInit() {
    fetchTanks();  // Load initial data
    super.onInit();
  }
}
