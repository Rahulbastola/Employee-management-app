
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/employe_controller.dart';
import 'add_employe.dart';
import 'employe_detail_page.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Logout
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // Remove JWT tokens
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');

    // Go to Login page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmployeController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 40,
        centerTitle: true,
        title: const Text(
          "Employee Management App",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Logout button
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              onChanged: (value) {
                controller.searchEmploye(value);
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Search Student',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Total Employee",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Obx(
            () => Text(
              '${controller.totalnumber()}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.filteredEmployes.length,
                itemBuilder: (context, index) {
                  final employe =
                      controller.filteredEmployes[index];

                  return Card(
                    child: ListTile(
                      title: Column(
                        children: [
                          Text(
                            'Name: ${employe.name}',
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Text(
                            'Position ${employe.position}',
                          ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                      onTap: () {
                        Get.to(
                          EmployeDetailPage(
                            employe: employe,
                            index: index,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          FloatingActionButton(
            onPressed: () {
              Get.to(
                () => const AddEmployePage(),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

