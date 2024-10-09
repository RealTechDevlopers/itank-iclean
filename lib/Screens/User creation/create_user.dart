// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'create_user_controller.dart';
// class CreateUsersPage extends StatelessWidget {
//   const CreateUsersPage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final CreateUsersController controller = Get.put(CreateUsersController());
//     final box = GetStorage();
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text(
//           'Create Users',
//           style: TextStyle(color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout_sharp, color: Colors.white),
//             onPressed: () {
//               // box.remove('isLoggedIn');
//               // controller.navigateToLogin();
//               _showLogoutDialog(context, box, controller);
//             },
//           ),
//         ],
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             _RoleCard("Admin", controller,),
//             const SizedBox(height: 16),
//             _RoleCard("President", controller,),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _RoleCard(String role, CreateUsersController controller,) {
//     return Container(
//       height: 60,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0),
//             child: Text(
//               role,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(
//               Icons.add,
//               color: Colors.white,
//               size: 24,
//             ),
//             onPressed: () {
//              controller.addUser(role);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//   void _showLogoutDialog(
//       BuildContext context, GetStorage box, CreateUsersController controller) {
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
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text("Logout"),
//               onPressed: () {
//                 box.remove('isLoggedIn');
//                 Navigator.of(context).pop();
//                 controller.navigateToLogin();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
// }
