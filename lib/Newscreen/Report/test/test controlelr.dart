
import 'package:get/get.dart';

class CleanController extends GetxController {
  // Cleaning data: Map of last cleaned dates and corresponding tank names
  var cleaningData = <DateTime, List<String>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Adding initial dummy data
    cleaningData[DateTime.utc(2024, 10, 1)] = ['Tank A'];
    cleaningData[DateTime.utc(2024, 10, 3)] = ['Tank B'];
  }

  // Check if cleaning is overdue (> 15 days)
  bool isOverdue(DateTime lastCleanedDate) {
    final difference = DateTime.now().difference(lastCleanedDate).inDays;
    return difference > 15;
  }

  // Check if cleaning is due soon (in the next 2 days)
  bool isDueSoon(DateTime lastCleanedDate) {
    final difference = DateTime.now().difference(lastCleanedDate).inDays;
    return difference >= 13 && difference <= 15;
  }

  // Get events for a particular day
  List<String> getEventsForDay(DateTime day) {
    return cleaningData[day] ?? [];
  }
}
