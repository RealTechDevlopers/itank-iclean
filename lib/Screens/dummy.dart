import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dummy_controller.dart';
class UserCreationScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final UserCreationController controller = Get.put(UserCreationController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Creation'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: controller.showAdminFields,
                    child: const Text("Add Admin"),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: controller.showPresidentFields,
                    child: const Text("Add President"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Admin Fields
              Obx(() => Visibility(
                visible: controller.isAdminVisible.value,
                child: _buildAdminForm(),
              )),

              // President Fields
              Obx(() => Visibility(
                visible: controller.isPresidentVisible.value,
                child: _buildPresidentForm(),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminForm() {
    return Column(
      children: [
        Text("Admin Creation", style: GoogleFonts.averiaSerifLibre(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _buildTextField("Admin Name"),
        const SizedBox(height: 10),
        _buildTextField("Admin Mobile Number", TextInputType.phone),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Handle Admin registration logic
          },
          child: const Text("Register Admin"),
        ),
      ],
    );
  }

  Widget _buildPresidentForm() {
    return Column(
      children: [
        Text("President Creation", style: GoogleFonts.averiaSerifLibre(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _buildTextField("President Name"),
        const SizedBox(height: 10),
        _buildTextField("President Mobile Number", TextInputType.phone),
        const SizedBox(height: 10),
        _buildDropdown("State Name", ['State 1', 'State 2', 'State 3']),
        const SizedBox(height: 10),
        _buildDropdown("District Name", ['District 1', 'District 2', 'District 3']),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Handle President registration logic
          },
          child: const Text("Register President"),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, [TextInputType keyboardType = TextInputType.text]) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
    );
  }

  Widget _buildDropdown(String label, List<String> items) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (value) {},
    );
  }
}
