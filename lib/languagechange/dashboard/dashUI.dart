import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Newscreen/jsondashboard/model.dart';
import '../camera/camUI.dart';
import '../login/loginUI.dart';
import 'dashcontroller.dart';

class CleanCalendar extends StatelessWidget {
  final String? username;
  final ListController tankController = Get.put(ListController());
  final box = GetStorage();

  CleanCalendar({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          username != null ? '${username} ${'dashboard'.tr}' : 'Dashboard'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.055,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username != null ? '${username} ${'menu'.tr}' : '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    if (tankController.tankList.isNotEmpty) {
                      var firstTank = tankController.tankList.first;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${'panchayat'.tr}: ${firstTank.panchayatName}', style: const TextStyle(color: Colors.white)),
                          Text('${'union'.tr}: ${firstTank.unionName}', style: const TextStyle(color: Colors.white)),
                          Text('${'tank Capacity'.tr}: ${firstTank.capacity} ${'Liters'.tr}', style: const TextStyle(color: Colors.white)),
                        ],
                      );
                    } else {
                      return Text('no tank data available'.tr, style: const TextStyle(color: Colors.white));
                    }
                  }),
                ],
              ),
            ),
            ExpansionTile(
              leading: Icon(Icons.info, color: Colors.green),
              title: Text('about iclean'.tr),
              children: [
                ListTile(
                  title: Text(
                    "scheduled Cleanings".tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "tanks are scheduled for cleaning every 15 days to maintain compliance. The app highlights tanks due for cleaning.".tr,
                  ),
                ),
                ListTile(
                  title: Text(
                    "overdue Notifications".tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "if tanks aren’t cleaned on time, the app shows indicators to alert users about overdue cleanings.".tr,
                  ),
                ),
                ListTile(
                  title: Text(
                    "clean Status Tracking".tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "each cleaning stage ('Before,' 'During,' 'After') is recorded with timestamps, images, and status icons, providing full transparency in the maintenance lifecycle.".tr,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Text(
                'select language'.tr,
                style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.045),
              ),
            ),
            Obx(() {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    // Ensure selected value matches items in the dropdown
                    value: tankController.selectedLanguage.value,
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.green),
                    iconSize: 28,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    items: tankController.languages.map((Map<String, String> lang) {
                      // Ensure unique values in DropdownMenuItem
                      return DropdownMenuItem<String>(
                        value: lang['name'],
                        child: Text(lang['name']!),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        // Log change to ensure Hindi is correctly set
                        print("Selected Language: $newValue");
                        tankController.changeLanguage(newValue);
                      }
                    },
                  ),
                ),
              );
            }),


            ListTile(
              leading: Icon(Icons.logout, color: Colors.green, size: screenWidth * 0.06),
              title: Text(
                'logout'.tr,
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
        child: RefreshIndicator(
          onRefresh: () async {
            await tankController.fetchTanks();
          },
          child: Obx(() {
            if (tankController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (tankController.errorMessage.isNotEmpty) {
              return Center(child: Text(tankController.errorMessage.value));
            }
            return ListView.builder(
              itemCount: tankController.tankList.length,
              itemBuilder: (context, index) {
                var tank = tankController.tankList[index];
                return _buildTankCard(tank, screenWidth);
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTankCard(Tank tank, double screenWidth) {
    Color dueDaysColor = (tank.daysCountAfterClean ?? 0) > 3
        ? Colors.green
        : (tank.daysCountAfterClean ?? 0) >= 1
        ? Colors.orange
        : Colors.red;

    return GestureDetector(
      onTap: () {
        Get.to(() => ImageScreen(tankName: tank.name, tank: tank));
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tank.name,
                          style: TextStyle(
                            fontSize: screenWidth * 0.048,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        CircleAvatar(
                          radius: screenWidth * 0.050,
                          backgroundColor: dueDaysColor,
                          child: Text(
                            (tank.daysCountAfterClean ?? 0).toString(),
                            style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.03),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    Text("${"last cleaned date".tr} : ${tank}".tr, style: TextStyle(fontSize: screenWidth * 0.038)),
                    SizedBox(height: screenWidth * 0.02),
                    Text("${"next cleaning date".tr} : ${tank}".tr, style: TextStyle(fontSize: screenWidth * 0.038)),
                  ],
                ),
              ),
            ],
          ),
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
            "logout".tr,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),
          ),
          content: Text(
            "are you sure you want to logout?".tr,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("cancel".tr, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text("logout".tr, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
              onPressed: () {
                box.remove('isLoggedIn');
                box.remove('username');
                Get.offAll(LogScreen());
              },
            ),
          ],
        );
      },
    );
  }
}
