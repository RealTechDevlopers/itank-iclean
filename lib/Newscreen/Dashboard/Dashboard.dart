import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Login/Login.dart';
import '../Report/test/Testreport.dart';
import 'Dashboardcontroller.dart';
import 'Model.dart';
class CleaningCalendar extends StatelessWidget {
  final TankController tankController = Get.put(TankController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PKTR',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.description),
            onPressed: () {
              Get.to(repo());
            },
          ),
        ],
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'PKTR Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {
                _showLogoutDialog(context, box);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return ListView.builder(
            itemCount: tankController.tankList.length,
            itemBuilder: (context, index) {
              var tank = tankController.tankList[index];
              return _buildTankCard(tank);
            },
          );
        }),
      ),
    );
  }

  Widget _buildTankCard(TankStatus tank) {
    Color dueDaysColor;
    if (tank.dueDays > 3) {
      dueDaysColor = Colors.green;
    } else if (tank.dueDays >= 1) {
      dueDaysColor = Colors.orange;
    } else {
      dueDaysColor = Colors.red;
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tank Icon
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green,
              backgroundImage: const AssetImage('assets/Images/personclean.png'),
            ),
            const SizedBox(width: 16),
            // Tank Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tank.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text("Due days: ", style: TextStyle(fontSize: 16)),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: dueDaysColor,
                        child: Text(
                          tank.dueDays.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Status Icons
            Row(
              children: List.generate(tank.status.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check,
                        color: (tank.status[index] == "Before")
                            ? Colors.green
                            : (tank.status[index] == "During")
                            ? Colors.orange
                            : Colors.red,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tank.status[index],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              }),
            ),
            // Location Icon
            IconButton(
              icon: Icon(
                Icons.location_on,
                color: tank.isLocationAvailable ? Colors.green : Colors.red,
              ),
              onPressed: () {
                // Location button pressed action
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
