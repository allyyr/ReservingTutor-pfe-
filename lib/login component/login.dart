import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:sapfd/login%20component/myb_tn.dart';
import 'package:sapfd/login%20component/text_field.dart';
import 'package:sapfd/view/Student_teacher.dart';
import 'package:sapfd/view/controll_view_S.dart';
import 'package:sapfd/view/teacher%20view/controll_view_T.dart';

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _LoginState();
}

class _LoginState extends State<login> {
  bool isTeacher = false;

  final emController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Form(
              key: formstate,
              child: Column(
                children: [
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Welcome Back, you've been missed",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 30),
                  mytextfield(
                    Controller: emController,
                    hintText: 'Username or Email',
                    obscureText: false,
                    validator: (val) {
                      if (val == "") {
                        return "Field can't be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  mytextfield(
                    Controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (val) {
                      if (val == "") {
                        return "Field can't be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('I am a Teacher'),
                      Switch(
                        value: isTeacher,
                        onChanged: (value) {
                          setState(() {
                            isTeacher = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  mybtn(
                    onTap: () async {
                      if (formstate.currentState!.validate()) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emController.text.trim(),
                            password: passwordController.text,
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => isTeacher
                                  ? ControlView_T(titre: 'Home')
                                  : ControlView_S(titre: 'Home'),
                            ),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
                            print('No user found for that email.');
                            showAwesomeDialog(
                                context, 'Password or email is incorrect');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                            showAwesomeDialog(context,
                                'Wrong password provided for that user.');
                          } else {
                            print('Error: ${e.message}');
                            showAwesomeDialog(
                                context, 'An error occurred: ${e.message}');
                          }
                        } catch (e) {
                          print('Error: $e');
                          showAwesomeDialog(
                              context, 'An unexpected error occurred.');
                        }
                      } else {
                        showAwesomeDialog(context, 'Fields are empty');
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 50),
                    child: Row(
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.black26),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            _navigateToSignUp(context);
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.blue,
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
      ),
    );
  }

  void _navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentTeacher()),
    );
  }

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
}
