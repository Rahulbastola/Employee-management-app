
import 'package:get/get.dart';

import '../models/employe_models.dart';
import '../services/employee_api_service.dart';

class EmployeController extends GetxController {
  var employes = <EmployeModels>[].obs;

  var filteredEmployes = <EmployeModels>[].obs;

  final EmployeeApiService apiService = EmployeeApiService();

  // GET
  Future<void> loadEmployees() async {
    final employees = await apiService.getEmployees();

    employes.assignAll(employees);
    filteredEmployes.assignAll(employees);
  }

  // POST
  Future<void> addEmploye(EmployeModels employee) async {
    final newEmployee = await apiService.addEmployee(employee);

    employes.add(newEmployee);
    filteredEmployes.assignAll(employes);
  }

  // PUT
  Future<void> editEmploye(
    int index,
    EmployeModels employee,
  ) async {
    final updatedEmployee = await apiService.updateEmployee(
      employee.id!,
      employee,
    );

    employes[index] = updatedEmployee;
    filteredEmployes.assignAll(employes);
  }

  // DELETE
  Future<void> deleteEmploye(int index) async {
    final employee = employes[index];

    await apiService.deleteEmployee(employee.id!);

    employes.removeAt(index);
    filteredEmployes.assignAll(employes);
  }

  // COUNT
  int totalnumber() {
    return employes.length;
  }

  // SEARCH
  void searchEmploye(String value) {
    if (value.isEmpty) {
      filteredEmployes.assignAll(employes);
    } else {
      filteredEmployes.assignAll(
        employes.where(
          (employee) => employee.name
              .toLowerCase()
              .contains(value.toLowerCase()),
        ),
      );
    }
  }
}
