import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/employe_models.dart';
import '../controllers/employe_controller.dart';
import 'edit_employe.dart';

class EmployeDetailPage extends StatelessWidget {
  final EmployeModels employe;
  final int index;

  const EmployeDetailPage({
    super.key,
    required this.employe,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmployeController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Employe Details')),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${employe.name}'),
            const SizedBox(height: 15),

            Text('Roll No: ${employe.email}'),
            const SizedBox(height: 15),

            Text('Class: ${employe.phone}'),
            const SizedBox(height: 15),

            Text('Age: ${employe.department}'),
            const SizedBox(height: 30),

            Text('Age: ${employe.position}'),
            const SizedBox(height: 30),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                  Get.to(
                    () => EditEmployePage(
                    employe: employe,
                    index: index,
                  ),
                );
                  },
                  child: const Text('Edit'),
                ),

                const SizedBox(width: 15),

                ElevatedButton(
                  onPressed: () async {
                  await controller.deleteEmploye(index);
                  Get.back();
                  },
               child: const Text('Delete'),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
