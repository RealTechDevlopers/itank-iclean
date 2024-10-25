import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'listtankcontroller.dart';

class TankListScreen extends StatelessWidget {
  final ListTankController controller = Get.put(ListTankController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tank List"),
      ),
      body: Obx(() {
        // Display loading indicator when loading data
        if (controller.isLoading.value && controller.tankList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        // Display error message if there’s an error
        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        // Show message if there’s no data to display
        if (controller.tankList.isEmpty) {
          return Center(child: Text("No data available"));
        }

        // Display the ListView when data is loaded
        return ListView.builder(
          itemCount: controller.tankList.length,
          itemBuilder: (context, index) {
            var tank = controller.tankList[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text(tank.devicename),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tank Name: ${tank.name}"),
                    Text("IMEI: ${tank.imei}"),
                    Text("Tank Cleaned Days: ${tank.daysCountAfterClean ?? 'N/A'}"),
                    SizedBox(height: 10),
                    Text("Image Statuses:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Before Image: ${tank.beforeImg.isNotEmpty ? 'Uploaded' : 'Pending'}"),
                    Text("During Image: ${tank.duringImg.isNotEmpty ? 'Uploaded' : 'Pending'}"),
                    Text("After Image: ${tank.afterImg.isNotEmpty ? 'Uploaded' : 'Pending'}"),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
