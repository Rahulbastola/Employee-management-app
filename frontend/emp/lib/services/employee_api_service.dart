import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/employe_models.dart';

class EmployeeApiService {
  final String baseUrl =
      'http://127.0.0.1:8000/api/employees/';
      

  // Get the saved access token
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('access_token');
  }

  // Create headers with JWT token
  Future<Map<String, String>> getHeaders({
    bool includeJson = false,
  }) async {
    final token = await getAccessToken();

    return {
      if (includeJson) 'Content-Type': 'application/json',
      if (token != null)
        'Authorization': 'Bearer $token',
    };
  }

  // GET - Get all employees
  Future<List<EmployeModels>> getEmployees() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: await getHeaders(),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data
          .map(
            (json) => EmployeModels.fromJson(json),
          )
          .toList();
    }

    throw Exception(
      'Failed to load employees: ${response.statusCode}',
    );
  }

  // POST - Add employee
  Future<EmployeModels> addEmployee(
    EmployeModels employee,
  ) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: await getHeaders(includeJson: true),
      body: jsonEncode(employee.toJson()),
    );

    if (response.statusCode == 201) {
      return EmployeModels.fromJson(
        jsonDecode(response.body),
      );
    }

    throw Exception(
      'Failed to add employee: ${response.statusCode}',
    );
  }

  // PUT - Update employee
  Future<EmployeModels> updateEmployee(
    int id,
    EmployeModels employee,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl$id/'),
      headers: await getHeaders(includeJson: true),
      body: jsonEncode(employee.toJson()),
    );

    if (response.statusCode == 200) {
      return EmployeModels.fromJson(
        jsonDecode(response.body),
      );
    }

    throw Exception(
      'Failed to update employee: ${response.statusCode}',
    );
  }

  // PATCH - Partially update employee
  Future<void> patchEmployee(
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await http.patch(
      Uri.parse('$baseUrl$id/'),
      headers: await getHeaders(includeJson: true),
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to patch employee: ${response.statusCode}',
      );
    }
  }

  // DELETE - Delete employee
  Future<void> deleteEmployee(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$id/'),
      headers: await getHeaders(),
    );

    if (response.statusCode != 204) {
      throw Exception(
        'Failed to delete employee: ${response.statusCode}',
      );
    }
  }
}
