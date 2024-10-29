import 'package:flutter/material.dart';
import 'package:iclean/Newscreen/Tamildashboard/tamilmodel.dart';
class LocationCard extends StatelessWidget {
  final Location location;
  LocationCard({required this.location});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '(${location.engName})',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'கடைசியாக சுத்தம் செய்யப்படும் தேதி',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    'Next cleaning date: ${location.nextDate}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4.0),
                  const Text(
                    'அடுத்து சுத்தம் செய்யப்படும் தேதி',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    'Last cleaned date: ${location.lastDate}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: location.status == 0
                    ? Colors.red
                    : location.status < 5
                    ? Colors.orange
                    : Colors.green,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12.0),
              child: Text(
                location.status.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
