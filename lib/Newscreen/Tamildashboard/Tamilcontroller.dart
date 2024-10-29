import 'package:get/get.dart';
import 'package:iclean/Newscreen/Tamildashboard/tamilmodel.dart';


class LocationController extends GetxController {
  var locations = <Location>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLocations();
  }

  void fetchLocations() {
    var fetchedLocations = [
      Location(name: 'புட்டன் காட்டு', engName: 'Puttan kattur', status: 15, nextDate: '16/10/2024', lastDate: '01/10/2024'),
      Location(name: 'வலசு பாளையம்', engName: 'valasu palayam', status: 0, nextDate: '16/10/2024', lastDate: '01/10/2024'),
      Location(name: 'எம்ஜிஆர் நகர', engName: 'MGR Nagar', status: 3, nextDate: '16/10/2024', lastDate: '01/10/2024'),
      Location(name: 'புதுப்பாளையம்', engName: 'Puthupalayam', status: 5, nextDate: '16/10/2024', lastDate: '01/10/2024'),
    ];
    locations.assignAll(fetchedLocations);
  }
}
