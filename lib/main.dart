import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sapfd/login%20component/login.dart';
import 'package:sapfd/view/controll_view_S.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sapfd/view/teacher%20view/controll_view_T.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null ? login() : HomeDecider(),
    );
  }
}

class HomeDecider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            body: Center(
              child: Text('Error fetching user role'),
            ),
          );
        }

        if (snapshot.data == 'student') {
          return ControlView_T(
            titre: 'Home',
          );
        } else {
          return ControlView_S(
            titre: 'Home',
          );
        }
      },
    );
  }

  Future<String?> _getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userDoc['role'];
    }
    return null;
  }
}
