import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left icon (cleaning icon)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.green,
                radius: 24,
                child: Icon(
                  Icons.cleaning_services,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            // Main content section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Basuvapatti',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Icon(
                          Icons.map_outlined,
                          color: Colors.green,
                          size: 28,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Due days and checklist
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Due days section
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 18,
                              child: Text(
                                '8',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Due days',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        // Checkmarks (Before, During, After)
                        Row(
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                                Text('Before'),
                              ],
                            ),
                            SizedBox(width: 16),
                            Column(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                                Text('during'),
                              ],
                            ),
                            SizedBox(width: 16),
                            Column(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                                Text('after'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Task Screen'),
      ),
      body: TaskCard(),
    ),
  ));
}
