// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapfd/util/custom_element.dart';
import 'package:sapfd/view/chat_view.dart';
import 'package:sapfd/view/high_school_view.dart';
import 'package:sapfd/view/middle_school_view.dart';
import 'package:sapfd/view/primary_school_view.dart';
import 'package:sapfd/view/university_view.dart';

// ignore: camel_case_types
class homeScreenPage extends StatefulWidget {
  const homeScreenPage({super.key});

  @override
  State<homeScreenPage> createState() => _homeScreenPageState();
}

// ignore: camel_case_types
class _homeScreenPageState extends State<homeScreenPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.001,
                    ),
                    const Text(
                      'Choose level',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      width: size.width * 0.8,
                      height: size.height * 0.37,
                      child: GridView.count(
                        crossAxisSpacing: 15,
                        crossAxisCount: 2,
                        children: const [
                          ChoseModuleButton(
                              image: 'images/highSchool.png',
                              text: 'gasdgfds',
                              ontPGoWidget: primaryView()),
                          ChoseModuleButton(
                              image: 'images/highSchool.png',
                              text: 'gasdgfds',
                              ontPGoWidget: middleView()),
                          ChoseModuleButton(
                              image: 'images/highSchool.png',
                              text: 'gasdgfds',
                              ontPGoWidget: highSchool()),
                          ChoseModuleButton(
                              image: 'images/highSchool.png',
                              text: 'math',
                              ontPGoWidget: universityView()),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.00001,
                    ),
                    const Text(
                      'Chat',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.009,
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          TextButton(
                            style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                            ),
                            child: const moduleList(
                              titre: 'Speaking Skills',
                              sousTitre: '15 exercice',
                              icon: Icons.favorite,
                              color: Colors.orange,
                            ),
                            onPressed: () {
                              Get.to(chatView());
                            },
                          ),
                          TextButton(
                            style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                            ),
                            child: const moduleList(
                              titre: 'Speaking Skills',
                              sousTitre: '15 exercice',
                              icon: Icons.numbers,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              Get.to(chatView());
                            },
                          ),
                          TextButton(
                            style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                            ),
                            child: const moduleList(
                              titre: 'Speaking Skills',
                              sousTitre: '15 exercice',
                              icon: Icons.mail,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              Get.to(chatView());
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}






/*
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          
                          //SizedBox(width: 20,),
                          /**/
                          InkWell(
                            splashColor: Color.fromARGB(255, 25, 162, 183),
                            onTap: () {
                              
                            },
                            child: Ink.image(
                              image: AssetImage('highSchool.png'),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black,
                                ),
                                padding: const EdgeInsets.only(left: 110,right: 90,bottom: 50,top: 100),
                              ),
                            ),
                          ),
                          
                          InkWell(
                            onTap: () {
                              
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black,
                              ),
                              
                              padding: const EdgeInsets.only(left: 110,right: 90,bottom: 50,top: 100),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //SizedBox(width: 10,),
                          InkWell(
                            onTap: () {
                              
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black,
                              ),
                              padding: const EdgeInsets.only(left: 110,right: 90,bottom: 50,top: 100),
                            ),
                          ),
                          
                         InkWell(
                            onTap: () {
                              
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black,
                              ),
                              padding: const EdgeInsets.only(left: 110,right: 90,bottom: 50,top: 100),
                            ),
                          ),
                        ],
                      ),*/







/*Container(
                decoration: BoxDecoration( 
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.black,
                        ),
                        SizedBox(width: 5,), 
                      Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                          
                        ),
                  
                        ),
                    ],
                  ),
                ),
              ),*/