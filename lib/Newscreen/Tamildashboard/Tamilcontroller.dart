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
      Location(
         // name: '',

          engName: 'Puttan kattur', status: 15, nextDate: '16/10/2024', lastDate: '01/10/2024'),
      Location(
         // name: '',
          engName: 'valasu palayam', status: 0, nextDate: '16/10/2024', lastDate: '01/10/2024'),
      Location(
          //name: '',
          engName: 'MGR Nagar', status: 3, nextDate: '16/10/2024', lastDate: '01/10/2024'),
      Location(
          //name: '',
          engName: 'Puthupalayam', status: 5, nextDate: '16/10/2024', lastDate: '01/10/2024'),
    ];
    locations.assignAll(fetchedLocations);
  }
}
