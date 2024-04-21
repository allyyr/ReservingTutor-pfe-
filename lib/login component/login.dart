import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:sapfd/login%20component/myb_tn.dart';
import 'package:sapfd/login%20component/text_field.dart';
import 'package:sapfd/view/controll_view.dart';
import 'package:sapfd/view/signUpPage.dart';

// ignore: must_be_immutable
class login extends StatefulWidget {
  login({super.key});
  final emController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

//login method
  void loginb() {}

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print(
            '==================================User is currently signed out!');
      } else {
        print('================================User is signed in!');
      }
    });
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Form(
            key: widget.formstate,
            child: Column(
              children: [
                //  SizedBox(height:30),
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 30),
                Text(
                  "welcome Back you've been missed",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                ),

                const SizedBox(height: 30),

                //username or email field

                mytextfield(
                  Controller: widget.emController,
                  hintText: 'Usernamer or Email',
                  obscureText: false,
                  validator: (val) {
                    if (val == "") {
                      return "field cant be empty";
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 30,
                ),

                //password field
                mytextfield(
                  Controller: widget.passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  validator: (val) {
                    if (val == "") {
                      return "field cant be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                //forget password

                Padding(
                  padding: const EdgeInsets.only(right: 270),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                //login button   Navigator.of(context).pushReplacementNamed("home_page");

                mybtn(
                  onTap: () async {
                    if (widget.formstate.currentState!.validate()) {
                      try {
                        // ignore: unused_local_variable
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: widget.emController.text.trim(),
                          password: widget.passwordController.text,
                        );
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
                        if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
                          print('No user found for that email.');
                          // ignore: use_build_context_synchronously
                          showAwesomeDialog(context, 'passworrd or email is');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                          // ignore: use_build_context_synchronously
                          showAwesomeDialog(context,
                              'Wrong password provided for that user.');
                        } else {
                          print('Error: ${e.message}');
                          // ignore: use_build_context_synchronously
                          showAwesomeDialog(
                              context, 'An error occurred: ${e.message}');
                        }
                      } catch (e) {
                        print('Error: $e');
                        // ignore: use_build_context_synchronously
                        showAwesomeDialog(
                            context, 'An unexpected error occurred.');
                      }
                    } else {
                      showAwesomeDialog(context, 'fields r empty');
                    }

                    /*try {
               final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                 email: widget.emController.text.trim(),
                 password: widget.passwordController.text,
               );
               Navigator.of(context).restorablePushReplacementNamed("home_page");
             } on FirebaseAuthException catch (e) {
               if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
                 print('No user found for that email.');
                 showAwesomeDialog(context, 'passworrd or email is');
               } else if (e.code == 'wrong-password') {
                 print('Wrong password provided for that user.');
                 showAwesomeDialog(context, 'Wrong password provided for that user.');
               } else {
                 print('Error: ${e.message}');
                 showAwesomeDialog(context, 'An error occurred: ${e.message}');
               }
             } catch (e) {
               print('Error: $e');
               showAwesomeDialog(context, 'An unexpected error occurred.');
             }*/
                  },
                ),

                // signin
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 50),
                  child: Row(
                    children: [
                      Text(
                        "Dont have an account? ",
                        style: TextStyle(color: Colors.black26),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {
                          _navigateToSignUp(context);
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors
                                .blue, // You can customize the color as needed
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void _navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => signUpPage()),
    );
  }
}

void loginb() {}
void showAwesomeDialog(BuildContext context, String message) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.rightSlide,
    title: 'Error',
    desc: message,
    btnCancelOnPress: () {},
    btnOkOnPress: () {},
  ).show();
}
