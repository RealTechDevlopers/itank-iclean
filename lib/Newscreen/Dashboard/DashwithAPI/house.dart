// tank_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'housecontroller.dart';
class TankPage extends StatelessWidget {
  final HouseController tankController = Get.put(HouseController());

  final TextEditingController unameController = TextEditingController();  // Input for uname
  final TextEditingController flagController = TextEditingController();  // Input for flag

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tank List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text field for uname
            TextField(
              controller: unameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 10),
            // Text field for flag
            TextField(
              controller: flagController,
              decoration: InputDecoration(labelText: 'Flag'),
            ),
            SizedBox(height: 20),
            // Button to fetch tank data
            ElevatedButton(
              onPressed: () {
                String uname = unameController.text;
                String flag = flagController.text;
                if (uname.isNotEmpty && flag.isNotEmpty) {
                  // Fetch tanks with uname and flag
                  tankController.fetchTanks(uname, flag);
                }
              },
              child: Text('Fetch Tanks'),
            ),
            SizedBox(height: 20),
            // Display the list of tanks or loading spinner
            Expanded(
              child: Obx(() {
                // Show loading spinner
                if (tankController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                // If there are no tanks, show a message
                if (tankController.tankList.isEmpty) {
                  return Center(child: Text('No tanks available'));
                }

                // Display the tank list
                return ListView.builder(
                  itemCount: tankController.tankList.length,
                  itemBuilder: (context, index) {
                    final tank = tankController.tankList[index];
                    return ListTile(
                      title: Text(tank.name),
                      subtitle: Text('Capacity: ${tank.capacity}, Location: ${tank.location}'),
                      leading: CircleAvatar(
                        child: Text(tank.id.toString()),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
