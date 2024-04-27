import 'package:flutter/material.dart';
import 'package:sapfd/util/color.dart';
import 'package:sapfd/util/custom_element.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController phoneNumberController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.blue,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              const Padding(
                padding: EdgeInsets.all(2.0),
                child: Center(
                  child: Text(
                    'Edit your profile information',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Center(
                child: SizedBox(
                  width: size.width * 0.3,
                  height: size.height * 0.14,
                  child: Container(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/highSchool.png'),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      border: Border.all(
                          color: AppColors.blue, width: size.width * 0.0047),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              CustomLoginButton(
                title: 'Change picture',
                backGrounfdColor: AppColors.blue,
                onnPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: size.height * 0.019,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(255, 25, 162, 183),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: [
                          champText(
                            Teext: "Phone Number",
                            mycontroller: phoneNumberController,
                          ),
                          champText(
                            Teext: "First Name",
                            mycontroller: firstNameController,
                          ),
                          champText(
                            Teext: "Family Name",
                            mycontroller: lastNameController,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                    ),
                    CustomLoginButton(
                      title: 'Valider',
                      backGrounfdColor: AppColors.blue,
                      onnPressed: () async {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.question,
                          animType: AnimType.bottomSlide,
                          title: 'Are you sure?',
                          desc: 'Do you want to save changes?',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () async {
                            // Get current user
                            User? user = FirebaseAuth.instance.currentUser;

                            // Update user data in Firestore
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user?.uid)
                                .update({
                              'phoneNum': phoneNumberController.text,
                              'firstName': firstNameController.text,
                              'lastName': lastNameController.text,
                            });

                            // Navigate back to profile view
                            Navigator.pop(context);
                          },
                        ).show();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
