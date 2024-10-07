// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// class showdata extends StatelessWidget {
//   const showdata({super.key});
//   @override
//   Widget build(BuildContext context) {
//     String jsonData = '''
//     [
//       {
//         "id": 1,
//         "name": "Item 1",
//         "description": "This is item 1"
//       },
//       {
//         "id": 2,
//         "name": "Item 2",
//         "description": "This is item 2"
//       }
//     ]
//     ''';
//     List<dynamic> items = jsonDecode(jsonData);
//     return Scaffold(
//       appBar: AppBar(title: Text('Item'),),
//       body: ListView.builder(itemBuilder: (context,index){final item = items[index] as Map<String,dynamic>;
//       return ListTile(
//         title: Text(item['name']),
//         subtitle: Text(item['description']),
//       );
//       }),
//     );
//   }
// }
