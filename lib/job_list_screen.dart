// job_list_screen.dart
import 'package:flutter/material.dart';
import 'dbHelper.dart';
import 'job.dart';

class JobListScreen extends StatefulWidget {
  @override
  _JobListScreenState createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Available Jobs')),
      body: jobs.isEmpty
          ? Center(child: Text('No jobs available'))
          : ListView.builder(
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(jobs[index].role),
                    subtitle: Text('${jobs[index].company} - ${jobs[index].location}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Here you can implement the apply functionality
                        // For example, you could show a dialog indicating the job has been applied for
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Apply for Job'),
                            content: Text('You have applied for ${jobs[index].role}.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text('Apply'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}