import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String apiUrl = 'http://devftp.itank.io/water/admin/icms_Api/userlist_gvt_pvt.php';
  Future<http.Response> sendTankDetailsRequest(String username) async {
    Map<String, dynamic> postData = {
      'username': username,
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(postData),
    );
    return response;
  }
}
