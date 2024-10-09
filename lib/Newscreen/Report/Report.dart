import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'Reportcontroller.dart';

class CleaningCalendar extends StatelessWidget {
  // Get an instance of the CleaningController
  final CleaningController cleaningController = Get.put(CleaningController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tank Cleaning Schedule'),
      ),
      body: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: DateTime.now(),
        eventLoader: (day) => cleaningController.getEventsForDay(day),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            return Obx(() {
              if (events.isNotEmpty) {
                DateTime lastCleanedDate = date;
                if (cleaningController.isOverdue(lastCleanedDate)) {
                  return _buildMarker(date, Colors.red);
                } else if (cleaningController.isDueSoon(lastCleanedDate)) {
                  return _buildMarker(date, Colors.orange);
                } else {
                  return _buildMarker(date, Colors.green);
                }
              }
              return SizedBox.shrink();
            });
          },
        ),
      ),
    );
  }

  // Function to build a color-coded marker
  Widget _buildMarker(DateTime date, Color color) {
    return Positioned(
      bottom: 1,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        width: 7.0,
        height: 7.0,
      ),
    );
  }
}
