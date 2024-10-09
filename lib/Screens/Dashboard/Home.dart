// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import '../User creation/admin_creation_controller.dart';
// import '../login/login_scr.dart';
// import 'Home_controller.dart';
//
// class Home extends StatelessWidget {
//   const Home({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final Home_Controller controller = Get.put(Home_Controller());
//     final AdminCreationControllerController adminController = Get.put(AdminCreationControllerController());
//     final box = GetStorage();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Obx(() => Text('Dashboard (${controller.filteredItem.length})', style: const TextStyle(color: Colors.white))),
//         backgroundColor: Colors.blue,
//       ),
//       drawer: Drawer(
//         backgroundColor: Colors.white,
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             UserAccountsDrawerHeader(
//               decoration: const BoxDecoration(
//                 color: Colors.blue,
//               ),
//               accountName: Obx(() => Text(adminController.userName.value.isEmpty ? "No Name" : adminController.userName.value)),
//               accountEmail: Obx(() => Text(adminController.userMobileNumber.value.isEmpty ? "No Mobile Number" : adminController.userMobileNumber.value)),
//               currentAccountPicture: CircleAvatar(
//                 backgroundColor: Colors.grey,
//                 child: Obx(() => adminController.selectedImage.value == null
//                     ? const Icon(Icons.person, size: 40)
//                     : ClipOval(
//                   child: Image.file(
//                     adminController.selectedImage.value!,
//                     width: 80,
//                     height: 80,
//                     fit: BoxFit.cover,
//                   ),
//                 )),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.person_add_alt_sharp),
//               title: const Text("Add Admin"),
//               onTap: () {
//                 controller.navigateToAdminscreen();
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.supervised_user_circle_rounded),
//               title: const Text('Add President'),
//               onTap: () {
//                 controller.navigateToRegisterScreen();
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text('Logout'),
//               onTap: () {
//                 _showLogoutDialog(context, box);
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: controller.filterItems,
//               decoration: InputDecoration(
//                 labelText: 'Search',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 prefixIcon: const Icon(Icons.search, color: Colors.black),
//                 contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               if (controller.filteredItem.isEmpty) {
//                 return const Center(child: Text('No items available'));
//               }
//               return ListView.builder(
//                 itemCount: controller.filteredItem.length,
//                 itemBuilder: (context, index) {
//                   final item = controller.filteredItem[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
//                     child: Card(
//                       margin: const EdgeInsets.symmetric(vertical: 5),
//                       elevation: 4,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: ListTile(
//                         contentPadding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
//                         leading: CircleAvatar(
//                           backgroundImage: AssetImage(item.imageUrl),
//                         ),
//                         title: Text(item.name, style: const TextStyle(color: Colors.black)),
//                         subtitle: Text(item.description, style: const TextStyle(color: Colors.black)),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showLogoutDialog(BuildContext context, GetStorage box) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Logout"),
//           content: const Text("Are you sure you want to logout?"),
//           actions: <Widget>[
//             TextButton(
//               child: const Text("Cancel"),
//               onPressed: () {
//                 Get.back();
//               },
//             ),
//             TextButton(
//               child: const Text("Logout"),
//               onPressed: () {
//                 box.remove('isLoggedIn');
//                 Get.offAll(LoginScr());
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
