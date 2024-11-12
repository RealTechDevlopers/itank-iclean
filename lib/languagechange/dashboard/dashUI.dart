import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
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
        actions: [
          IconButton(onPressed: (){
            _showLogoutDialog(context, box);
          }, icon: const Icon(Icons.logout))
        ],
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
                          Text('${'panchayat'.tr}: ${firstTank.panchayatName}',
                              style: const TextStyle(color: Colors.white)),
                          Text('${'union'.tr}: ${firstTank.unionName}',
                              style: const TextStyle(color: Colors.white)),
                          Text(
                              '${'tank Capacity'.tr}: ${firstTank.capacity} ${'L'.tr}',
                              style: const TextStyle(color: Colors.white)),
                        ],
                      );
                    } else {
                      return Text('no tank data available'.tr,
                          style: const TextStyle(color: Colors.white));
                    }
                  }),
                ],
              ),
            ),
            ExpansionTile(
              leading: const Icon(Icons.info, color: Colors.green),
              title: Text('about iclean'.tr),
              children: [
                ListTile(
                  title: Text(
                    "scheduled Cleanings".tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "tanks are scheduled for cleaning every 15 days to maintain compliance. The app highlights tanks due for cleaning."
                        .tr,
                  ),
                ),
                ListTile(
                  title: Text(
                    "overdue Notifications".tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "if tanks aren’t cleaned on time, the app shows indicators to alert users about overdue cleanings."
                        .tr,
                  ),
                ),
                ListTile(
                  title: Text(
                    "clean Status Tracking".tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "each cleaning stage ('Before,' 'During,' 'After') is recorded with timestamps, images, and status icons, providing full transparency in the maintenance lifecycle."
                        .tr,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Text(
                'select language'.tr,
                style: TextStyle(
                    color: Colors.black, fontSize: screenWidth * 0.045),
              ),
            ),
            Obx(() {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: tankController.selectedLanguage.value,
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
                    iconSize: 28,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    items: tankController.languages
                        .map((Map<String, String> lang) {
                      return DropdownMenuItem<String>(
                        value: lang['name'],
                        child: Text(lang['name']!),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        tankController.changeLanguage(newValue);
                      }
                    },
                  ),
                ),
              );
            }),
            ListTile(
              leading: Icon(Icons.logout,
                  color: Colors.green, size: screenWidth * 0.06),
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
    Color dueDaysColor;
    int? daysCountAfterClean = tank.displaydayscount ?? 0;

    // int daysRemaining = tank.daysRemaining;
    if (daysCountAfterClean > 3) {
      dueDaysColor = Colors.green;
    } else if (daysCountAfterClean >= 1) {
      dueDaysColor = Colors.orange;
    } else {
      dueDaysColor = Colors.red;
    }

    return GestureDetector(
      onTap: () {
        log("coming");
        log(tank.beforeImg + tank.duringImg);
        Get.to(() => ImageScreen(
              tank: tank,

            ));
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
                        Expanded(
                          flex: 3, // Adjust flex as needed
                          child: Text(
                            tank.tankName,
                            style: TextStyle(
                              fontSize: screenWidth * 0.048,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1, // Adjust flex as needed
                          child: CircleAvatar(
                            radius: screenWidth * 0.060,
                            backgroundColor: dueDaysColor,
                            // child: Text(
                            //   (tank.daysCountAfterClean ?? 0).toString(),
                            //   style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: screenWidth * 0.03),
                            // ),
                            child: Text(
                              daysCountAfterClean.toString(), // Display countdown days
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.04,
                              ),
                          ),
                          )
                        )
                      ],
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    Row(
                      children: [
                        Expanded(
                          flex: 4, // Adjust flex as needed for spacing
                          child: Text(
                            "${"last cleaned date".tr}",
                            style: TextStyle(fontSize: screenWidth * 0.036,fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Expanded(child: Text("-")),
                        Expanded(
                          flex: 2, // Adjust flex as needed
                          child: Text(
                            "11-11-2024",
                            // " ${tank}".tr,
                            style: TextStyle(fontSize: screenWidth * 0.036,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    Row(
                      children: [
                        Expanded(
                          flex: 4, // Adjust flex as needed for spacing
                          child: Text(
                            "${"next cleaning date".tr}",
                            style: TextStyle(fontSize: screenWidth * 0.036,fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Expanded(
                            flex: 1,
                            child: Text("-")),
                        Expanded(
                          flex: 2,
                          child: Text(
                            tank.lastAfterImageUpload != null
                                ? DateFormat('yyyy-MM-dd').format(
                              tank.lastAfterImageUpload!.add(const Duration(days: 14)),
                            )
                                : '26-11-2024',
                            style: TextStyle(fontSize: screenWidth * 0.036,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
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
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),
          ),
          content: Text(
            "are you sure you want to logout?".tr,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("cancel".tr,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04)),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text("logout".tr,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04)),
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
