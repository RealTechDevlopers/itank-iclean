import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
class CalendarController extends GetxController {
  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;
  var calendarFormat = CalendarFormat.month.obs;
  var events = <DateTime, List<String>>{}.obs;
  @override
  void onInit() {
    super.onInit();
    events[DateTime.utc(2024, 10, 9)] = ['Event 1', 'Event 2'];
    events[DateTime.utc(2024, 10, 10)] = ['Event 3'];
  }

  List<String> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }
  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
  }
  void onFormatChanged(CalendarFormat format) {
    calendarFormat.value = format;
  }
}
