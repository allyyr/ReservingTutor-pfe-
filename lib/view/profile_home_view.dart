import 'package:flutter/material.dart';
import 'package:sapfd/util/color.dart';
import 'package:sapfd/util/custom_element.dart';
import 'package:sapfd/view/change_password_view.dart';
import 'package:sapfd/view/edit_profile_view.dart';
import 'package:sapfd/view/information_view.dart';
import 'package:sapfd/view/loginPage.dart';
import 'package:get/get.dart';


class ProfileHomeView extends StatelessWidget {
  const ProfileHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                //width: 120,
                height: size.height * 0.15,
                child: Container(
                  
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    //borderRadius: BorderRadius.circular(40),
                    color: Colors.black,
                    border: Border.all(color: AppColors.blue, width: 2),
                  ),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('images/highSchool.png'),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                'Ali Rougab',
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
                  Get.to(editProfile());
                },
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              const Divider(),
              SizedBox(
                height: size.height * 0.019,
              ),
              
              profileMenuWidget(
                  title: 'Informations',
                  icone: Icons.info_rounded,
                  onPress: () {
                    Get.to(const informationView());
                  }),
              profileMenuWidget(
                  title: 'Change Password',
                  icone: Icons.password,
                  onPress: () {
                    Get.to(const changePassword());
                  }),
              const Divider(),
              const Divider(),
              SizedBox(
                height: size.height * 0.01,
              ),
              profileMenuWidget(
                title: 'Logout',
                icone: Icons.logout_rounded,
                onPress: () {
                  Get.to(HomePage());
                },
                endIcon: false,
                textColor: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
