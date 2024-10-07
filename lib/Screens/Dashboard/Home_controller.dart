import 'package:get/get.dart';
import '../User creation/admin_creation.dart';
import '../User creation/president_creation.dart';
import '../login/login_scr.dart';
import 'Model_data.dart';

class Home_Controller extends GetxController {
  var isAdminVisible = true.obs;
  var isPresidentVisible = false.obs;
  var item = <Item>[].obs;
  var filteredItem = <Item>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchItem();
  }
  void fetchItem(){
    var jsondata=[
      {
        "id": 1,
        "name": "Ram",
        "description": "Thingalur",
         "imageUrl": "assets/Images/men.jpg"
      },
      {
        "id": 2,
        "name": "periyasami",
        "description": "kumaravalsu",
      "imageUrl": "assets/Images/men.jpg"
      },
      {
        "id": 3,
        "name": "Ramesh",
        "description": "This is item 3",
      "imageUrl": "assets/Images/men.jpg"
      },
      {
        "id": 4,
        "name": "Item 4",
        "description": "This is item 4",
        "imageUrl": "assets/Images/men.jpg"
      },
      {
        "id": 5,
        "name": "Item 5",
        "description": "This is item 5",
        "imageUrl": "assets/Images/men.jpg"
      },
      {
        "id": 6,
        "name": "Item 7",
        "description": "This is item 7",
        "imageUrl": "assets/Images/men.jpg"
      }, {
        "id": 8,
        "name": "Item 8",
        "description": "This is item 8",
        "imageUrl": "assets/Images/men.jpg"
      }, {
        "id": 9,
        "name": "Item 9",
        "description": "This is item 9",
        "imageUrl": "assets/Images/men.jpg"
      }, {
        "id": 10,
        "name": "Item 10",
        "description": "This is item 10",
        "imageUrl": "assets/Images/men.jpg"
      }
    ];
    for(var data in jsondata) {
      item.add(Item.fromJson(data));
    }
    filteredItem.assignAll(item);
  }

  void filterItems(String query){
    searchQuery.value = query;
    if (query.isEmpty){
      filteredItem.assignAll(item);
    }else{
      filteredItem.assignAll(item.where((item) => item.name.toLowerCase().contains(query.toLowerCase()) || item.description.toLowerCase().contains(query.toLowerCase())));
    }
  }


  void showAdminFields() {
    isAdminVisible.value = true;
    isPresidentVisible.value = false;
  }

  void showPresidentFiels() {
    isAdminVisible.value = false;
    isPresidentVisible.value = true;
  }

  void navigateToLogin() {
    Get.to(LoginScr());
  }

  void navigateToAdminscreen() {
   Get.to(Adminscreen());
  }

  void navigateToRegisterScreen() {
    Get.to(PresidentScreen());
  }
}
