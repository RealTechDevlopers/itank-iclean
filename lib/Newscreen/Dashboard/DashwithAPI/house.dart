// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'housecontroller.dart';
// class TankPage extends StatelessWidget {
//   final HouseController tankController = Get.put(HouseController());
//   final TextEditingController unameController = TextEditingController();
//   final TextEditingController flagController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tank List'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: unameController,
//               decoration: const InputDecoration(labelText: 'Username'),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: flagController,
//               decoration: const InputDecoration(labelText: 'Flag'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 String uname = unameController.text;
//                 String flag = flagController.text;
//                 if (uname.isNotEmpty && flag.isNotEmpty) {
//                   tankController.fetchTanks(uname, flag);
//                 }
//               },
//               child: const Text('Fetch Tanks'),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: Obx(() {
//                 if (tankController.isLoading.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (tankController.tankList.isEmpty) {
//                   return const Center(child: Text('No tanks available'));
//                 }
//                 return ListView.builder(
//                   itemCount: tankController.tankList.length,
//                   itemBuilder: (context, index) {
//                     final tank = tankController.tankList[index];
//                     return ListTile(
//                       title: Text(tank.name),
//                       subtitle: Text('Capacity: ${tank.capacity}, Location: ${tank.location}'),
//                       leading: CircleAvatar(
//                         child: Text(tank.id.toString()),
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
