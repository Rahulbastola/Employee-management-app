
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/employe_controller.dart';
import '../models/employe_models.dart';

class AddEmployePage extends StatelessWidget {
  const AddEmployePage({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeController controller =
        Get.find<EmployeController>();

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final departmentController = TextEditingController();
    final positionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 20,
        centerTitle: true,
        title: const Text(
          'Add Employee',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter employee name',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter email',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  hintText: 'Enter phone number',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: departmentController,
                decoration: const InputDecoration(
                  labelText: 'Department',
                  hintText: 'Enter department',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: positionController,
                decoration: const InputDecoration(
                  labelText: 'Position',
                  hintText: 'Enter position',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () async {
                  final name = nameController.text.trim();
                  final email = emailController.text.trim();
                  final phone = phoneController.text.trim();
                  final department =
                      departmentController.text.trim();
                  final position =
                      positionController.text.trim();

                  if (name.isEmpty ||
                      email.isEmpty ||
                      phone.isEmpty ||
                      department.isEmpty ||
                      position.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Please fill all fields',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );

                    return;
                  }

                  try {
                    final phoneNumber = double.parse(phone);

                    await controller.addEmploye(
                      EmployeModels(
                        name: name,
                        email: email,
                        phone: phoneNumber,
                        department: department,
                        position: position,
                      ),
                    );

                    Get.snackbar(
                      'Success',
                      'Employee added successfully',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );

                    Get.back();
                  } catch (e) {
                    Get.snackbar(
                      'Error',
                      e.toString(),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 5),
                    );

                    print('ADD EMPLOYEE ERROR: $e');
                  }
                },
                child: const Text('Add Employee'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

