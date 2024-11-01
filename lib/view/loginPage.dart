// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sapfd/util/color.dart';
import 'package:sapfd/util/custom_element.dart';
import 'package:sapfd/view/controll_view_S.dart';
import 'package:sapfd/view/forgot_password_view.dart';
import 'package:sapfd/view/signUpPage.dart';
import 'package:get/get.dart';
/*



class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!--------------------');
      } else {
        print('User is signed in!');
      }
    });
  }

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
                height: size.height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                    SizedBox(
                      height: size.height * 0.007,
                    ),
                    const Text(
                      'Welcome back',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
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
                        height: size.height * 0.09,
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
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                    hintText: "Email or Phone number",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                            CustomTextFiel(
                              pass: "Password",
                              mycontroller: _passwordController,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.to(const forgotPassword());
                          },
                          child: const Text(
                            'Forgot password ?',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )),
                      SizedBox(
                        height: size.height * 0.07,
                      ),
                      CustomLoginButton(
                          title: "Login",
                          onnPressed: () async {
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email.text,
                                      password: password.text);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ControlView(
                                    titre: 'Home',
                                    userData: {},
                                  ),
                                ),
                              );
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                              }
                            }
                          }),

                      /*  Get.to(const ControlView(
                            titre: 'Home',
                          )); */
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => signUpPage()));
                          Get.to(() => signUpPage(),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 500));
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New user ?',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              ' Create account',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 18),
                            )
                          ],
                        ),
                      ),
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
/*  title: "Login",
                        backGrounfdColor: AppColors.blue,
                        onnPressed: () async {
                          // Trim whitespace from the email
                          final trimmedEmail = email.text.trim();

                          try {
                            // Sign in the user with email and password
                            final userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: trimmedEmail,
                              password: password.text,
                            );

                            // If login is successful, fetch user data from Firestore
                            if (userCredential.user != null) {
                              final userData = await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(userCredential.user!.uid)
                                  .get();
                              // Extract user data from the document snapshot
                              final email = userData.get('email');
                              /*   final phoneNumber = userData.get('phoneNumber');
                              final firstName = userData.get('firstName');
                              final lastName = userData.get('lastName'); */

                              // Navigate to the home screen, passing user data if needed
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ControlView(
                                    titre: 'Home',
                                    userData: {
                                      'email': email,
                                      /* 'phoneNumber': phoneNumber,
                                      'firstName': firstName,
                                      'lastName': lastName, */
                                      // Add more user data fields as needed
                                    },
                                  ),
                                ),
                              );
                            }
                          } on FirebaseAuthException catch (e) {
                            // Handle FirebaseAuth exceptions
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            } else {
                              print('Error during login: ${e.message}');
                            }
                          } catch (e) {
                            // Handle other exceptions
                            print('Error during login: $e');
                          }
                        }, */
 */