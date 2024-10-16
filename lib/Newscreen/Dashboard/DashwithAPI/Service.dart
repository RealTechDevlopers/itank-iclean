import 'package:http/http.dart' as http;
import 'dart:convert';
import 'housemodel.dart';
class TankService {
  static var client = http.Client();
  static Future<List<TankModel>> fetchTanks(String uname, String flag) async {
    var response = await client.post(
      Uri.parse('https://www.itank.io/api/tank_live_universal.php'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'uname': uname,
        'flag': flag,
      },
    );
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return (jsonData as List).map((tank) => TankModel.fromJson(tank)).toList();
    } else {
      throw Exception('Failed to load tanks');
    }
  }
}
