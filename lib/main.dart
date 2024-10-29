// main.dart
import 'package:flutter/material.dart';
import 'package:jobportal/login_page.dart';
import 'package:jobportal/signup_page.dart';
import 'dbHelper.dart';
import 'job.dart';
import 'job_list_screen.dart';
import 'recruiter_screen.dart';

void main() {
  runApp(JobPortalApp());
}

class JobPortalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Portal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),

        '/signup': (context) => SignupPage(),
        '/recruiter': (context) => RecruiterScreen(),
        '/seeker': (context) => JobListScreen(),


        // Add a home route if you have a home page

        // '/home': (context) => HomePage(),
      },
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Job Portal')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => RecruiterScreen()),
//                 );
//               },
//               child: Text('Recruiter'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => JobListScreen()),
//                 );
//               },
//               child: Text('Job Seeker'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
