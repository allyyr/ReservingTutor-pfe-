import 'package:flutter/material.dart';
import 'package:sapfd/view/signUpPage.dart';

class StudentTeacher extends StatelessWidget {
  const StudentTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Role'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to sign-up page with role = true (student)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => signUpPage(role: 'student'),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Student',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Space between the two buttons
            GestureDetector(
              onTap: () {
                // Navigate to sign-up page with role = false (teacher)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => signUpPage(role: 'teacher'),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Teacher',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
