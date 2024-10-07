import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iclean/Screens/Dashboard/pre_home_controller.dart';


class TankListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final preHomeController = Get.put(pre_home_controller());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Obx(() {
          return Text(
            'Home (${preHomeController.filteredItem.length})',
            style: const TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          );
        }),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: preHomeController.filterItems,
              decoration: InputDecoration(
                labelText: 'Search',
                labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
                // fillColor: Colors.white,
                // filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25), // Rounded border
                  // borderSide: BorderSide.none, // No border line
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (preHomeController.filteredItem.isEmpty) {
                return const Center(child: Text('No items available', style: TextStyle(fontSize: 18)));
              }

              return ListView.builder(
                itemCount: preHomeController.filteredItem.length,
                itemBuilder: (context, index) {
                  final item = preHomeController.filteredItem[index];
                  return Card(
                    elevation: 4, // Adds shadow to the card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          radius: 25,
                          child: Icon(
                            Icons.water_damage, // Tank icon
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          item.tankname,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis, // Handle overflowed text
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 6),
                            Text(
                              'Tank Number: ${item.tanknumber}',
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis, // Handle overflowed text
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Expanded( // Wrap to ensure no overflow
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Due Days: ',
                                      style: DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
                                      children: [
                                        TextSpan(
                                          text: '${item.duedays}',
                                          style: TextStyle(
                                            color: item.duedays <= 0 ? Colors.red : Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Expanded(
                                //   child: RichText(
                                //     text: TextSpan(
                                //       text: 'Remaining Days: ',
                                //       style: DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
                                //       children: [
                                //         // TextSpan(
                                //         //   text: '${item.remainingdays}',
                                //         //   style: TextStyle(
                                //         //     color: Colors.green.shade700,
                                //         //     fontWeight: FontWeight.bold,
                                //         //   ),
                                //         // ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
