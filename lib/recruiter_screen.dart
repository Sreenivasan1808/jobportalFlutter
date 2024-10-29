// recruiter_screen.dart
import 'package:flutter/material.dart';
import 'dbHelper.dart';
import 'job.dart';
import 'package:flutter/material.dart';

class RecruiterScreen extends StatefulWidget {
  @override
  _RecruiterScreenState createState() => _RecruiterScreenState();
}

class _RecruiterScreenState extends State<RecruiterScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _roleController = TextEditingController();

  final TextEditingController _companyController = TextEditingController();

  final TextEditingController _salaryController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _locationController = TextEditingController();

  List<Job> jobs = [];

  @override
  void initState() {
    super.initState();

    _loadJobs();
  }

  Future<void> _loadJobs() async {
    jobs = await dbHelper.getJobs();

    setState(() {});
  }

  Future<void> _addJob() async {
    if (_formKey.currentState!.validate()) {
      try {
        await dbHelper.insertJob(Job(
          role: _roleController.text,
          company: _companyController.text,
          salary: double.tryParse(_salaryController.text) ?? 0,
          description: _descriptionController.text,
          location: _locationController.text,
        ));

        _roleController.clear();

        _companyController.clear();

        _salaryController.clear();

        _descriptionController.clear();

        _locationController.clear();

        _loadJobs(); // Refresh the list of jobs
      } catch (e) {
        // Show an error message if something goes wrong

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding job: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recruiter Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _roleController,
                    decoration: InputDecoration(labelText: 'Role'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a role';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _companyController,
                    decoration: InputDecoration(labelText: 'Company'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a company';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _salaryController,
                    decoration: InputDecoration(labelText: 'Salary'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a salary';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _locationController,
                    decoration: InputDecoration(labelText: 'Location'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a location';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addJob,
                    child: Text('Post Job'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('Posted Jobs:', style: TextStyle(fontSize: 20)),
            Expanded(
              child: ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(jobs[index].role),
                      subtitle: Text(
                          '${jobs[index].company} - ${jobs[index].location}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await dbHelper.deleteJob(jobs[index].id!);
                          _loadJobs();
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
