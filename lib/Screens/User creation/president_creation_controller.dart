import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var selectedState = 'Tamil Nadu'.obs;
  var selectedDistrict = 'Erode'.obs;
  //var selectedGvtCategory = 'Admin'.obs;
  var selectedCategory = 'Rural Development'.obs;
  var selectedUnion = /*Rx<String?>(null);*/ 'Union 1'.obs;
  var selectedPanchayat = /*Rx<String?>(null);*/ 'Panchayat 1'.obs;

  //List<String> categorie = ['Admin','President'];
  List<String> states = ['Tamil Nadu', 'Kerala', 'Karnataka', 'Andhra'];
  List<String> districts = ['Erode', 'Coimbatore', 'Selam', 'Madhurai', 'Karur'];
  List<String> categories = ['Rural Development', 'Urban Development'];
  List<String> unions = ['Union 1', 'Union 2', 'Union 3'];
  List<String> panchayats = ['Panchayat 1', 'Panchayat 2', 'Panchayat 3'];

  void submitForm() {
    if (formKey.currentState!.validate()) {
      print('Form submitted successfully!');
      print('categorie${selectedCategory.value}');
      print('State: ${selectedState.value}');
      print('District: ${selectedDistrict.value}');
    //  print('Gvt Category: ${selectedGvtCategory.value}');
      print('Union: ${selectedUnion.value}');
      print('Panchayat: ${selectedPanchayat.value}');
    } else {
      Get.snackbar('Error', 'Please fill all required fields',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }
}
