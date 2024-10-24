import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';

class TankService {
  final String apiUrl = 'http://devftp.itank.io/water/iNeer/api/icleanApi/iclean_tankList.php';

  // Ensure this is not static
  Future<TankDataResponse?> fetchTanks(String username) async {
    try {
      final url = Uri.parse(apiUrl);
      final response = await http.post(url, body: {'username': username});

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        // Ensure you're correctly parsing the response
        if (jsonData['status'] == 'success') {
          return TankDataResponse.fromJson(jsonData);  // Return TankDataResponse object
        } else {
          throw Exception("Failed to fetch tanks: ${jsonData['message']}");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching tanks: $e");
      return null;  // Return null in case of failure
    }
  }
}
