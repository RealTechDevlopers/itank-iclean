import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iclean/Screens/User%20creation/president_creation_controller.dart';

class PresidentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.put(RegisterController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              const SizedBox(height: 100),
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(Icons.camera_alt, size: 40),
              ),
              const SizedBox(height: 20),
              _buildTextField(label: "Person Name"),
              const SizedBox(height: 10),
              _buildTextField(
                  label: "Mobile Number", keyboardType: TextInputType.phone),
              const SizedBox(height: 10),
              // _buildDropdown(
              //     label: "Select category",
              //     selectedValue: controller.selectedCategory,
              //     items: controller.categorie),
              _buildDropdown(
                label: "State Name",
                selectedValue: controller.selectedState,
                items: controller.states,
              ),
              const SizedBox(height: 10),
              _buildDropdown(
                label: "District Name",
                selectedValue: controller.selectedDistrict,
                items: controller.districts,
              ),
              const SizedBox(height: 10),
              _buildDropdown(
                label: "Gvt Category",
                selectedValue: controller.selectedCategory,
                items: controller.categories,
              ),
              const SizedBox(height: 10),
              _buildDropdown(
                label: "Union Name",
                selectedValue: controller.selectedUnion,
                items: controller.unions,
              ),
              const SizedBox(height: 10),
              _buildDropdown(
                label: "Panchayat Name",
                selectedValue: controller.selectedPanchayat,
                items: controller.panchayats,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  controller.submitForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E4E4E),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 80.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Register",
                  style: GoogleFonts.averiaSerifLibre(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 5),
        TextFormField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required RxString selectedValue,
    required List<String> items,
  }) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 5),
          DropdownButtonFormField<String>(
            value: selectedValue.value.isNotEmpty ? selectedValue.value : null,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                selectedValue.value = value;
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select $label';
              }
              return null;
            },
          ),
        ],
      );
    });
}
}
