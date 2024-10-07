import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'Api service.dart';
class TankController extends GetxController {
  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  var responseMessage = ''.obs;
  Future<void> sendTankDetails(String username) async {
    isLoading(true);
    try {
      final http.Response response = await apiService.sendTankDetailsRequest(username);
      // Check the response status
      if (response.statusCode == 200) {
        // Success - API call was successful
        responseMessage.value = 'Success: ${response.body}';
      } else {
        // Failure - something went wrong
        responseMessage.value = 'Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      // Error occurred (network or other issue)
      responseMessage.value = 'Error occurred: $e';
    }
    isLoading(true);  // Hide loading state
  }
}
