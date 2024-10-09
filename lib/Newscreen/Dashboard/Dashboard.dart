import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Login/Login.dart';
import 'DashboardController.dart';
class Dssh extends StatelessWidget {
  const Dssh({super.key});
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final DashboardController controller = Get.put(DashboardController());  // Instantiate the controller
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PKTR',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              accountName: Text('PkTR'),
              accountEmail: Text('Ponmudi'),
              currentAccountPicture: CircleAvatar(),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
               _showLogoutDialog(context, box);
              },
            ),
          ],
        ),
      ),
    );
  }
  void _showLogoutDialog(BuildContext context, GetStorage box) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text("Logout"),
              onPressed: () {
                box.remove('isLoggedIn');
                Get.offAll(LogScreen());
              },
            ),
          ],
        );
      },
    );
  }
}
