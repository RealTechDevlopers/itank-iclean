import 'package:get/get.dart';

class CleaningController extends GetxController {
  // Cleaning data as an observable
  var cleaningData = <DateTime, List<String>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Adding dummy data for testing
    cleaningData[DateTime.utc(2024, 10, 1)] = ['Tank A'];
    cleaningData[DateTime.utc(2024, 10, 3)] = ['Tank B'];
  }

  // Check if a tank cleaning is overdue (> 15 days)
  bool isOverdue(DateTime lastCleanedDate) {
    return DateTime.now().difference(lastCleanedDate).inDays > 15;
  }

  // Check if a tank cleaning is due soon (within 2 days)
  bool isDueSoon(DateTime lastCleanedDate) {
    final difference = DateTime.now().difference(lastCleanedDate).inDays;
    return difference >= 13 && difference <= 15;
  }

  // Function to get events (cleanings) for a specific day
  List<String> getEventsForDay(DateTime day) {
    return cleaningData[day] ?? [];
  }
}
