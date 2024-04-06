// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapfd/util/custom_element.dart';
import 'package:sapfd/view/loginPage.dart';

// ignore: camel_case_types
class signUpPage extends StatelessWidget {
  const signUpPage({super.key});

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
                height: size.height*0.02,
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
                height: size.height*0.03,
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
                        height: size.height*0.03,
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
                        child: const Column(
                          children: [
                            champText(Teext: "Email"),
                            champText(Teext: "Phone Number"),
                            champText(Teext: "First Name"),
                            champText(Teext: "Family Name"),
                            CustomTextFiel(pass: "Password"),
                            CustomTextFiel(pass: "Confirm Password"),
                          ],
                        ),
                      ),
                       SizedBox(
                        height: size.height*0.045,
                      ),
                      CustomLoginButton(
                        title: "Signup",
                        onnPressed: () {},
                      ),
                       SizedBox(
                        height: size.height*0.025,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                            Get.to(() => HomePage(),
                                transition: Transition.leftToRight,
                                duration: const Duration(milliseconds: 599));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'already has account ?',
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
