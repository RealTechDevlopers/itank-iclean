import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Login/Login.dart';
import '../jsondashboard/model.dart';
import 'Dashboardcontroller.dart';

class CleaningCalendar extends StatelessWidget {
  final String? username;  // Accept username as a parameter
  final ListTankController tankController = Get.put(ListTankController());  // Initialize ListTankController
  final box = GetStorage();

  // Constructor to accept the username
  CleaningCalendar({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          username != null ? '$username\'s Dashboard' : 'Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.055,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                username != null ? '$username\'s Menu' : 'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red, size: screenWidth * 0.06),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: screenWidth * 0.045),
              ),
              onTap: () {
                _showLogoutDialog(context, box);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Obx(() {
          // Show loading indicator when data is being fetched
          if (tankController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          // Show error message if there was an error fetching data
          if (tankController.errorMessage.isNotEmpty) {
            return Center(child: Text(tankController.errorMessage.value));
          }

          // Display the tank list once data is available
          return ListView.builder(
            itemCount: tankController.tankList.length,
            itemBuilder: (context, index) {
              var tank = tankController.tankList[index];
              return _buildTankCard(tank, screenWidth);
            },
          );
        }),
      ),
    );
  }

  Widget _buildTankCard(Tank tank, double screenWidth) {
    Color dueDaysColor = (tank.daysCountAfterClean ?? 0) > 3
        ? Colors.green
        : (tank.daysCountAfterClean ?? 0) >= 1
        ? Colors.orange
        : Colors.red;

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tank Icon on the left
            CircleAvatar(
              radius: screenWidth * 0.08,
              backgroundColor: Colors.greenAccent.shade700,
              backgroundImage: AssetImage('assets/Images/personclean.png'),
            ),
            SizedBox(width: screenWidth * 0.04),
            // Tank Information in the middle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tank.name,
                    style: TextStyle(
                      fontSize: screenWidth * 0.048,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Row(
                    children: [
                      Text(
                        "Due days: ",
                        style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black54),
                      ),
                      CircleAvatar(
                        radius: screenWidth * 0.035,
                        backgroundColor: dueDaysColor,
                        child: Text(
                          (tank.daysCountAfterClean ?? 0).toString(),
                          style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.03),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Status Icons stacked vertically on the right side
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatusIcon(screenWidth, "Before", tank.beforeImg),
                SizedBox(height: screenWidth * 0.02),
                _buildStatusIcon(screenWidth, "During", tank.duringImg),
                SizedBox(height: screenWidth * 0.02),
                _buildStatusIcon(screenWidth, "After", tank.afterImg),
              ],
            ),
          ],
        ),
      ),
    );
  }


  // Helper function to create status icons for Before, During, After based on image availability
  Widget _buildStatusIcon(double screenWidth, String status, String imgPath) {
    bool hasData = imgPath.isNotEmpty;  // Check if the image path exists
    Color iconColor = hasData ? Colors.green : Colors.red;
    IconData iconData = hasData ? Icons.check_circle : Icons.cancel;

    return Row(
      children: [
        Icon(
          iconData,
          color: iconColor,
          size: screenWidth * 0.06,
        ),
        SizedBox(width: screenWidth * 0.01),
        Text(
          status,
          style: TextStyle(fontSize: screenWidth * 0.032, color: Colors.black87),
        ),
      ],
    );
  }

  // Logout dialog function
  void _showLogoutDialog(BuildContext context, GetStorage box) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Logout",
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text("Logout", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
              onPressed: () {
                box.remove('isLoggedIn');
                box.remove('username');
                Get.offAll(LoginScreen());
              },
            ),
          ],
        );
      },
    );
  }
}
