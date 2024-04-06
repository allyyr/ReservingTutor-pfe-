import 'package:flutter/material.dart';
import 'package:sapfd/util/color.dart';
import 'package:sapfd/util/custom_element.dart';

// ignore: camel_case_types
class changePassword extends StatelessWidget {
  const changePassword({super.key});

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
              height: size.height*0.09,
            ),
            const Text(
              'Changing your Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
             SizedBox(
              height: size.height*0.02,
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
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                      CustomTextFiel(pass: "Enter Old Password"),
                      CustomTextFiel(pass: "Enter New Password"),
                      CustomTextFiel(pass: "Confirm New Password"),

                    ],
                  ),
                ),
                 SizedBox(
                  height: size.height*0.11,
                ),
                CustomLoginButton(
                  title: 'Valider',
                  backGrounfdColor: AppColors.blue,
                  onnPressed: () {},
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
