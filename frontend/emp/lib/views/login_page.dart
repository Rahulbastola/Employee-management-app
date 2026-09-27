
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/employe_controller.dart';
import 'register_page.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    final url = Uri.parse(
      'http://127.0.0.1:8000/api/token/',
    );

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final accessToken = data['access'];
      final refreshToken = data['refresh'];

      // Get SharedPreferences
      final prefs = await SharedPreferences.getInstance();

      // Store access token
      await prefs.setString(
        'access_token',
        accessToken,
      );

      // Store refresh token
      await prefs.setString(
        'refresh_token',
        refreshToken,
      );

      print('Tokens saved successfully');

      // Get EmployeeController
      final controller = Get.find<EmployeController>();

      // Load employees after JWT is saved
      await controller.loadEmployees();

      print('Employees loaded successfully');

      // Go to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      print('Login failed');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username or password'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                loginUser(context);
              },
              child: const Text('Login'),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                );
              },
              child: const Text(
                "Don't have an account? Register",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

