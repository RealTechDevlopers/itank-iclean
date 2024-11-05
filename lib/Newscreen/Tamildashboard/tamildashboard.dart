import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iclean/Newscreen/Tamildashboard/tamilcard.dart';
import 'Tamilcontroller.dart';
class DashboardScreen extends StatelessWidget {
  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: const Icon(Icons.menu),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          //  Text('பிகேடிஆர் டாஷ்போர்டு', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
            Text('PKTR Dashboard', style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
          ],
        ),
        actions: const [
          Icon(Icons.exit_to_app),
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (locationController.locations.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: locationController.locations.length,
            itemBuilder: (context, index) {
              return LocationCard(location: locationController.locations[index]);
            },
          );
        }
      }),
    );
  }
}
