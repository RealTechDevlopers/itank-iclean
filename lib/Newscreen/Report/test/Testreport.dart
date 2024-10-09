import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendarcontroller.dart';
class CalendarPage extends StatelessWidget {
  final CalendarController calendarController = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Table Calendar with GetX')),
      body: Column(
        children: [
          Obx(() => TableCalendar(
            focusedDay: calendarController.focusedDay.value,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            calendarFormat: calendarController.calendarFormat.value,
            selectedDayPredicate: (day) {
              return isSameDay(calendarController.selectedDay.value, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              calendarController.onDaySelected(selectedDay, focusedDay);
            },
            eventLoader: (day) => calendarController.getEventsForDay(day),
            onFormatChanged: (format) {
              calendarController.onFormatChanged(format);
            },
            onPageChanged: (focusedDay) {
              calendarController.focusedDay.value = focusedDay;
            },
          )),
          Obx(() {
            final events = calendarController.getEventsForDay(calendarController.selectedDay.value);
            return Column(
              children: events
                  .map((event) => ListTile(title: Text(event)))
                  .toList(),
            );
          }),
        ],
      ),
    );
  }
}
