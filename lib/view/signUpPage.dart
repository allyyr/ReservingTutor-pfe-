import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapfd/login%20component/login.dart';
import 'package:sapfd/util/custom_element.dart';
import 'package:sapfd/view/controll_view_S.dart';
import 'package:sapfd/view/homeScreenPage.dart';
import 'package:sapfd/view/loginPage.dart';
import 'package:sapfd/view/teacher%20view/controll_view_T.dart';

// ignore: camel_case_types
class signUpPage extends StatelessWidget {
  final String role;

  signUpPage({super.key, required this.role});
  TextEditingController email = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 25, 162, 183)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Signup Page',
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
                child: Padding(
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
                            champText(
                              Teext: "Email",
                              mycontroller: email,
                            ),
                            champText(
                              Teext: "Phone Number",
                              mycontroller: phoneNum,
                            ),
                            champText(
                              Teext: "First Name",
                              mycontroller: firstname,
                            ),
                            champText(
                              Teext: "Family Name",
                              mycontroller: lastname,
                            ),
                            CustomTextFiel(
                              pass: "Password",
                              mycontroller: password,
                            ),
                            /* CustomTextFiel(
                              pass: "Confirm Password",
                              mycontroller: passwordConfirm,
                            ), */
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.045,
                      ),
                      CustomLoginButton(
                        title: "Signup",
                        onnPressed: () async {
                          // Trim whitespace from the email and validate format
                          final trimmedEmail = email.text.trim();
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(trimmedEmail)) {
                            print('Invalid email format');
                            return; // Exit the signup process if email format is invalid
                          }

                          try {
                            final credential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: trimmedEmail,
                              password: password
                                  .text, // Use password.text to get the entered password
                            );
                            print('Signup successful');
                            if (credential != null) {
                              // Save user data to Firestore
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(credential.user!.uid)
                                  .set({
                                'email': trimmedEmail,
                                'password': password.text,
                                'phoneNum': phoneNum.text,
                                'firstName': firstname.text,
                                'lastName': lastname.text,
                                'role': role,

                                // Use password.text to get the entered password
                                // Add more user data fields as needed
                              });

                              // Navigate to the home screen
                              if (role == 'student') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ControlView_S(titre: 'Home'),
                                  ),
                                );
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ControlView_T(titre: 'Home'),
                                  ),
                                );
                              }
                            }
                          } on FirebaseAuthException catch (e) {
                            // Handle FirebaseAuth exceptions
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                            } else {
                              print('Error during signup: ${e.message}');
                            }
                          } catch (e) {
                            // Handle other exceptions
                            print('Error during signup: $e');
                          }
                        },
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => login()));
                            Get.to(() => login(),
                                transition: Transition.leftToRight,
                                duration: const Duration(milliseconds: 599));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'already have account ?',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                              Text(
                                ' Login',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 18),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
