import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'listtankcontroller.dart';

class TankListScreen extends StatelessWidget {
  final listtankController controller = Get.put(listtankController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tank List"),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.tankList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        return ListView.builder(
          itemCount: controller.tankList.length + 1,
          itemBuilder: (context, index) {
            if (index == controller.tankList.length) {
              if (controller.hasMoreData.value) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Center(child: Text("No more data"));
              }
            }
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
