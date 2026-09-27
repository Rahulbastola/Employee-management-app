class EmployeModels {
  int? id;
  String name;
  String email;
  double phone;
  String department;
  String position;

  EmployeModels({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.department,
    required this.position,
  });

  factory EmployeModels.fromJson(Map<String, dynamic> json) {
    return EmployeModels(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: double.parse(json['phone'].toString()),
      department: json['department'],
      position: json['position'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'department': department,
      'position': position,
    };
  }
}