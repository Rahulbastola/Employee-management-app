
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/employe_models.dart';
import '../controllers/employe_controller.dart';

class EditEmployePage extends StatelessWidget {
  final EmployeModels employe;
  final int index;

  EditEmployePage({
    super.key,
    required this.employe,
    required this.index,
  });

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final departmentController = TextEditingController();
  final positionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Put the existing employee data into the text fields
    nameController.text = employe.name;
    emailController.text = employe.email;
    phoneController.text = employe.phone.toString();
    departmentController.text = employe.department;
    positionController.text = employe.position;

    final EmployeController controller = Get.find<EmployeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Employee'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: departmentController,
              decoration: const InputDecoration(
                labelText: 'Department',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: positionController,
              decoration: const InputDecoration(
                labelText: 'Position',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () async {
                final updatedEmployee = EmployeModels(
                  id: employe.id,
                  name: nameController.text,
                  email: emailController.text,
                  phone: double.parse(phoneController.text),
                  department: departmentController.text,
                  position: positionController.text,
                );

                await controller.editEmploye(
                  index,
                  updatedEmployee,
                );

                Get.back();
              },

              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
