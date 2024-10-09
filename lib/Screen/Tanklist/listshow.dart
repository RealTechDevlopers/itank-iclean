// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../Screens/Tank clean/tank clean.dart';
// import 'listshowcontroller.dart';
// class TankListshow extends StatelessWidget {
//   final TankListController controller = Get.put(TankListController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         title: const Text('Tank List',style: TextStyle(color: Colors.white),),
//         backgroundColor: Colors.green,
//       ),
//       body: Obx(() {
//         if (controller.tankList.isEmpty) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           return ListView.builder(
//             itemCount: controller.tankList.length,
//             itemBuilder: (context, index) {
//               final tank = controller.tankList[index];
//               return Card(
//                 margin: const EdgeInsets.all(8.0),
//                 child: ListTile(
//                   leading: const CircleAvatar(
//                     backgroundColor: Colors.green,
//                     radius: 25,
//                     child: Icon(
//                       Icons.water_damage, // Tank icon
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                   ),
//                   title: Text(tank.tankName, style: const TextStyle(fontSize: 18)),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 3),
//                       // Text(
//                       //   'Tank Number: ${tank.dueDays}',
//                       //   style: const TextStyle(fontSize: 16),
//                       //   overflow: TextOverflow.ellipsis, // Handle overflowed text
//                       // ),
//                       const SizedBox(height: 6),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: RichText(
//                               text: TextSpan(
//                                 text: 'Due Days:',
//                                 style: DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
//                                 children: [
//                                   TextSpan(
//                                     text: '${tank.dueDays}',
//                                     style: TextStyle(
//                                       color: tank.dueDays <= 0 ? Colors.red : Colors.green,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   onTap: (){
//                     Get.to(TankScreen());
//                   },
//                 ),
//               );
//             },
//           );
//         }
//       }),
//     );
//   }
// }
