class Job {
  final int? id;
  final String role;
  final String company;
  final double salary;
  final String description;
  final String location;

  Job({
    this.id,
    required this.role,
    required this.company,
    required this.salary,
    required this.description,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'company': company,
      'salary': salary,
      'description': description,
      'location': location,
    };
  }

  @override
  String toString() {
    return 'Job{id: $id, role: $role, company: $company, salary: $salary, description: $description, location: $location}';
  }
}