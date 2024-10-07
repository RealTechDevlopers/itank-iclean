import 'package:get/get.dart';
import 'package:iclean/Screens/Dashboard/pre_home_model.dart';

class pre_home_controller extends GetxController{
  var filteredItem = <Items>[].obs;
  var searchQuery = ''.obs;
  var items =  <Items>[].obs;
  @override
  void onInit(){
    super.onInit();
    fetchItems();
  }
void fetchItems(){
    var jsondata=[
      {
        "id": 1,
        "tankname": "Water Tank Alpha",
        "tanknumber": 101,
        "duedays": -5,
        "remainingdays": 15,
      },
      {
        "id": 2,
        "tankname": "Fuel Tank Bravo",
        "tanknumber": 202,
        "duedays": -3,
        "remainingdays": 7,
      },
      {
        "id": 3,
        "tankname": "Chemical Tank Delta",
        "tanknumber": 303,
        "duedays": 0,
        "remainingdays": 12,
      },
      {
        "id": 4,
        "tankname": "Oil Tank Echo",
        "tanknumber": 404,
        "duedays": 10,
        "remainingdays": 20,
      },
      {
        "id": 5,
        "tankname": "Waste Tank Foxtrot",
        "tanknumber": 505,
        "duedays": -1,
        "remainingdays": 5,
      },
    ];
    for (var data in jsondata) {
      // if (data['remainingdays'] != 0) {
            //   items.add(Items.fromJson(data));
            // }
      items.add(Items.fromJson(data));
    }
    filteredItem.assignAll(items);
}
  void filterItems(String query){
    searchQuery.value = query;
    if (query.isEmpty){
      filteredItem.assignAll(items);
    }else{
      filteredItem.assignAll(
          items.where((item) =>
          item.tankname.toLowerCase().contains(query.toLowerCase())
              //||
              // item.tanknumber.toLowerCase().contains(query.toLowerCase())
          )
      );
    }
  }


}

