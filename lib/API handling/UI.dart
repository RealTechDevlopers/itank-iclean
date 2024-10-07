import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'UI_controller.dart';
class TankDetailsScreen extends StatelessWidget {
  final TankController tankController = Get.put(TankController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tank Details API'),
      ),
      body: Center(
        child: Obx(() {
          if (tankController.isLoading.value) {
            return CircularProgressIndicator();  // Show loading indicator
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Trigger the API request with the username "pktr"
                  tankController.sendTankDetails("pktr");
                },
                child: Text('Send POST Request'),
              ),
              SizedBox(height: 20),
              Text(tankController.responseMessage.value),
            ],
          );
        }),
      ),
    );
  }
}
