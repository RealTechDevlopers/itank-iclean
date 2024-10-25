import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Login/Login.dart';
import 'Dashboardcontroller.dart';
import 'Model.dart';

class CleaningCalendar extends StatelessWidget {
  final TankController tankController = Get.put(TankController());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PKTR',
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
                'PKTR Menu',
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

  Widget _buildTankCard(TankStatus tank, double screenWidth) {
    Color dueDaysColor;
    if (tank.dueDays > 3) {
      dueDaysColor = Colors.green;
    } else if (tank.dueDays >= 1) {
      dueDaysColor = Colors.orange;
    } else {
      dueDaysColor = Colors.red;
    }

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: screenWidth * 0.08,
              backgroundColor: Colors.greenAccent.shade700,
              backgroundImage: AssetImage('assets/Images/personclean.png'),
            ),
            SizedBox(width: screenWidth * 0.04),
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
                          tank.dueDays.toString(),
                          style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.03),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: tank.status.map((status) {
                // Determine icon and color based on status data availability
                bool hasData = (status == "Before" || status == "During" || status == "After");
                Color iconColor = hasData ? Colors.green : Colors.red;
                IconData iconData = hasData ? Icons.check_circle : Icons.cancel;

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: screenWidth * 0.005),
                  child: Row(
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
                  ),
                );
              }).toList(),
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
                Get.offAll(LoginScreen());
              },
            ),
          ],
        );
      },
    );
  }
}
