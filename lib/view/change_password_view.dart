import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sapfd/util/color.dart';
import 'package:sapfd/util/custom_element.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Change_Password_view extends StatefulWidget {
  const Change_Password_view({Key? key});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<Change_Password_view> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? errorText;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.blue,
        title: const Text(
          'Reset Password',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.09,
            ),
            const Text(
              'Changing your Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const Padding(
              padding: EdgeInsets.all(25.0),
              child: Center(
                child: Text(
                  'Change Password for more security',
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: size.height * 0.03,
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
                        CustomTextFiel(
                          pass: "Enter Old Password",
                          mycontroller: oldPasswordController,
                        ),
                        CustomTextFiel(
                          pass: "Enter New Password",
                          mycontroller: newPasswordController,
                        ),
                        CustomTextFiel(
                          pass: "Confirm New Password",
                          mycontroller: confirmPasswordController,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.11,
                  ),
                  CustomLoginButton(
                    title: 'Valider',
                    backGrounfdColor: AppColors.blue,
                    onnPressed: () async {
                      if (newPasswordController.text !=
                          confirmPasswordController.text) {
                        // Passwords don't match, show dialog
                        AwesomeDialog(
                          context: context,
                          dialogType:
                              DialogType.error, // Use ERROR directly here
                          animType: AnimType.rightSlide,
                          title: 'Password Mismatch',
                          desc: 'New passwords do not match.',
                          btnCancelOnPress: () {},
                        )..show();
                        return;
                      }

                      try {
                        // Get current user
                        User? user = FirebaseAuth.instance.currentUser;

                        // Reauthenticate user
                        AuthCredential credential =
                            EmailAuthProvider.credential(
                          email: user?.email ?? '',
                          password: oldPasswordController.text,
                        );
                        await user?.reauthenticateWithCredential(credential);

                        // Check if old password is correct
                        if (user != null && user.uid != null) {
                          // Change password
                          await user.updatePassword(newPasswordController.text);

                          // Show success message or navigate to another page
                          print('Password changed successfully');
                        } else {
                          // Show error dialog if user or uid is null
                          AwesomeDialog(
                            context: context,
                            dialogType:
                                DialogType.error, // Use ERROR directly here
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'An error occurred. Please try again.',
                            btnCancelOnPress: () {},
                          )..show();
                        }
                      } catch (e) {
                        // Handle errors
                        AwesomeDialog(
                          context: context,
                          dialogType:
                              DialogType.error, // Use ERROR directly here
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Incorrect old password.',
                          btnCancelOnPress: () {},
                        )..show();
                        print('Error changing password: $e');
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
