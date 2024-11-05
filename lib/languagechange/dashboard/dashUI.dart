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
          username != null ? '$username dashboard'.tr : 'Dashboard'.tr,
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
                    username != null ? '$username Menu' : "",
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
                          Text('Panchayat: ${firstTank.panchayatName}', style: const TextStyle(color: Colors.white)),
                          Text('Union: ${firstTank.unionName}', style: const TextStyle(color: Colors.white)),
                          Text('Tank Capacity: ${firstTank.capacity} Liters', style: const TextStyle(color: Colors.white)),
                        ],
                      );
                    } else {
                      return const Text('No tank data available', style: TextStyle(color: Colors.white));
                    }
                  }),
                ],
              ),
            ),
            const ExpansionTile(
              leading: Icon(Icons.info, color: Colors.green),
              title: Text('About iClean'),
              children: [
                ListTile(
                  title: Text(
                    "Scheduled Cleanings",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Tanks are scheduled for cleaning every 15 days to maintain compliance. The app highlights tanks due for cleaning.",
                  ),
                ),
                ListTile(
                  title: Text(
                    "Overdue Notifications",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "If tanks aren’t cleaned on time, the app shows indicators to alert users about overdue cleanings.",
                  ),
                ),
                ListTile(
                  title: Text(
                    "Clean Status Tracking",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Each cleaning stage ('Before,' 'During,' 'After') is recorded with timestamps, images, and status icons, providing full transparency in the maintenance lifecycle.",
                  ),
                ),
              ],
            ),
          //  const SizedBox(height: 20),
            Padding(padding: EdgeInsets.all(screenWidth * 0.04),
              child: Text(
                "Select Language",
                style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.045),
              ),
            ),
            Obx(() {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                 // color: Colors.white,
                 // borderRadius: BorderRadius.circular(8),
                  // border: Border.all(
                  //   color: Colors.green,
                  //   width: 2,
                  // ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.2),
                  //     spreadRadius: 2,
                  //     blurRadius: 4,
                  //     offset: Offset(0, 3),
                  //   ),
                  // ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: tankController.selectedLanguage.value,
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.green),
                    iconSize: 28,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    hint: Text(
                      'Select Language',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    items: tankController.languages.map((Map<String, String> lang) {
                      return DropdownMenuItem<String>(
                        value: lang['name'], // Use the language name for display
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

            //  const Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.green, size: screenWidth * 0.06),
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
                      children:[
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
              ]
              ),
                    //SizedBox(height: screenWidth * 0.02),
                    // Row(
                    //   children: [
                    //     Text(
                    //       "Due days: ",
                    //       style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black54),
                    //     ),
                    //     CircleAvatar(
                    //       radius: screenWidth * 0.035,
                    //       backgroundColor: dueDaysColor,
                    //       child: Text(
                    //         (tank.daysCountAfterClean ?? 0).toString(),
                    //         style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.03),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: screenWidth * 0.02),
                    Text("last cleaned date : 13/10/2024",style: TextStyle(fontSize: screenWidth * 0.038,),),
                    SizedBox(height: screenWidth * 0.02),
                    Text("next cleaning date: 28/10/2024",style: TextStyle(fontSize: screenWidth * 0.038),),
                  ],
                ),
              ),
              const Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // children: [
                //   _buildStatusIcon(screenWidth, "Before", tank.beforeImg),
                //   SizedBox(height: screenWidth * 0.02),
                //   _buildStatusIcon(screenWidth, "During", tank.duringImg),
                //   SizedBox(height: screenWidth * 0.02),
                //   _buildStatusIcon(screenWidth, "After", tank.afterImg),
                // ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(double screenWidth, String status, String imgPath) {
    bool hasData = imgPath.isNotEmpty;
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
                Get.offAll(LogScreen());
              },
            ),
          ],
        );
      },
    );
  }
}
