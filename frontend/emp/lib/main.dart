
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/employe_controller.dart';
import 'views/register_page.dart';

void main() {
  Get.put(EmployeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Employee Management App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterPage(),
    );
  }
}