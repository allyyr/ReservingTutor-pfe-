import 'package:flutter/material.dart';
import 'package:sapfd/login%20component/login.dart';
import 'package:sapfd/util/color.dart';
import 'package:sapfd/util/custom_element.dart';
import 'package:sapfd/view/change_password_view.dart';
import 'package:sapfd/view/edit_profile_view.dart';
import 'package:sapfd/view/information_view.dart';
import 'package:sapfd/view/loginPage.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileHomeView extends StatelessWidget {
  const ProfileHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // Get current user
    User? user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('No user data found');
        }

        // Extract user data from snapshot
        var userData = snapshot.data!.data() as Map<String, dynamic>;

        // Concatenate first name and last name
        String fullName = '${userData['lastName']} ${userData['firstName']}';

        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.019,
                  ),
                  SizedBox(
                    width: size.height * 0.15,
                    height: size.height * 0.15,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                        border: Border.all(color: AppColors.blue, width: 2),
                      ),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/highSchool.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    fullName, // Display full name
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  CustomLoginButton(
                    title: 'Edit Profile',
                    backGrounfdColor: AppColors.blue,
                    onnPressed: () {
                      Get.to(EditProfile());
                    },
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Divider(),
                  SizedBox(
                    height: size.height * 0.019,
                  ),
                  profileMenuWidget(
                    title: 'Informations',
                    icone: Icons.info_rounded,
                    onPress: () {
                      Get.to(const informationView());
                    },
                  ),
                  profileMenuWidget(
                    title: 'Change Password',
                    icone: Icons.password,
                    onPress: () {
                      Get.to(const Change_Password_view());
                    },
                  ),
                  Divider(),
                  Divider(),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  profileMenuWidget(
                    title: 'Logout',
                    icone: Icons.logout_rounded,
                    onPress: () {
                      FirebaseAuth.instance.signOut(); // Sign out the user
                      Get.offAll(() => login()); // Navigate to login page
                    },
                    endIcon: false,
                    textColor: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
