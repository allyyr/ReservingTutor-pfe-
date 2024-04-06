import 'package:flutter/material.dart';
import 'package:sapfd/util/color.dart';
import 'package:sapfd/util/custom_element.dart';

class editProfile extends StatelessWidget {
  const editProfile({super.key});

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
                height: size.height*0.03,
              ),
              const Padding(
                padding: EdgeInsets.all(2.0),
                child: Center(
                  child: Text(
                    'Edit your profile informations',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
               SizedBox(
                height: size.height*0.04,
              ),
              Center(
                child: SizedBox(
                  width: size.width*0.3,
                  height: size.height*0.14,
                  child: Container(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/highSchool.png'),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //borderRadius: BorderRadius.circular(40),
                      color: Colors.black,
                      border: Border.all(color: AppColors.blue, width: size.width*0.0047),
                    ),
                  ),
                ),
              ),
               SizedBox(
                height: size.height*0.015,
              ),
              CustomLoginButton(
                title: 'Change picture',
                backGrounfdColor: AppColors.blue,
                onnPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                   SizedBox(
                    height: size.height*0.019,
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
                        champText(Teext: "Phone Number"),
                        champText(Teext: "First Name"),
                        champText(Teext: "Family Name"),
                      ],
                    ),
                  ),
                   SizedBox(
                    height: size.height*0.08,
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
      ),
    );
  }
}
