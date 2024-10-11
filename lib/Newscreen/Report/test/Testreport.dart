import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'test controlelr.dart';
class repo extends StatelessWidget {
  final CleanController cleaningController = Get.put(CleanController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tank Cleaning Schedule',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        elevation: 0,
        shadowColor: Colors.purpleAccent,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: DateTime.now(),
                eventLoader: (day) {
                  return cleaningController.getEventsForDay(day);
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (events.isNotEmpty) {
                      return Obx(() {
                        if (cleaningController.cleaningData.containsKey(date)) {
                          DateTime lastCleanedDate = date;
                          if (cleaningController.isOverdue(lastCleanedDate)) {
                            return _buildMarker(Colors.red);
                          } else if (cleaningController.isDueSoon(lastCleanedDate)) {
                            return _buildMarker(Colors.orange);
                          } else {
                            return _buildMarker(Colors.green);
                          }
                        }
                        return const SizedBox.shrink();
                      });
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildMarker(Color color) {
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
