import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapfd/util/color.dart';

class CustomLoginButton extends StatelessWidget {
  const CustomLoginButton(
      {super.key,
      required this.title,
      this.backGrounfdColor,
      required this.onnPressed});
  final String title;
  final Color? backGrounfdColor;
  final VoidCallback onnPressed;
  @override
  Widget build(BuildContext context) {
    var taille = MediaQuery.of(context).size;
    return Container(
      width: taille.width * 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: FloatingActionButton(
        heroTag: null,
        backgroundColor:
            backGrounfdColor == null ? AppColors.blue : backGrounfdColor!,
        onPressed: onnPressed,
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustomTextFiel extends StatelessWidget {
  const CustomTextFiel({super.key, required this.pass, this.mycontroller});
  final String pass;
  final TextEditingController? mycontroller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: TextField(
          controller: mycontroller,
          decoration: InputDecoration(
              hintText: pass,
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none),
          obscureText: true),
    );
  }
}

// ignore: camel_case_types
class champText extends StatelessWidget {
  const champText({super.key, required this.Teext, this.mycontroller});
  final String Teext;
  final TextEditingController? mycontroller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: TextField(
        controller: mycontroller,
        decoration: InputDecoration(
            hintText: Teext,
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none),
      ),
    );
  }
}

// ignore: camel_case_types
class moduleList extends StatelessWidget {
  const moduleList(
      {super.key,
      required this.titre,
      required this.sousTitre,
      required this.icon,
      required this.color});
  final String titre;
  final String sousTitre;
  final icon;
  final color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
                padding: const EdgeInsets.all(12),
                color: color,
                child: Icon(
                  icon,
                  color: Colors.white,
                )),
          ),
          title: Text(titre),
          subtitle: Text(sousTitre),
        ),
      ),
    );
  }
}

class ChoseModuleButton extends StatelessWidget {
  const ChoseModuleButton(
      {super.key,
      required this.image,
      required this.text,
      required this.ontPGoWidget});
  final String image, text;
  final Widget ontPGoWidget;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.to(
          ontPGoWidget,
          transition: Transition.downToUp,
          duration: const Duration(milliseconds: 300),
        );
      },
      child: Container(
          height: size.height * 0.1,
          width: size.width * 0.3,
          margin: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, offset: Offset(1, 4), blurRadius: 10)
              ]),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: Image.asset(image),
              ),
              Text(
                text,
                style: TextStyle(
                    color: AppColors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              )
            ],
          )),
    );
  }
}

// ignore: camel_case_types
class profileMenuWidget extends StatelessWidget {
  final String title;
  final IconData icone;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  const profileMenuWidget({
    super.key,
    required this.title,
    required this.icone,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.blue.withOpacity(0.1),
        ),
        child: Icon(
          icone,
          color: AppColors.blue,
        ),
      ),
      title: Text(
        title,
        style:
            Theme.of(context).textTheme.headlineSmall?.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.blue.withOpacity(0.1),
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.blue,
              ),
            )
          : null,
    );
  }
}

// ignore: camel_case_types
class chooseLevel extends StatelessWidget {
  const chooseLevel({
    super.key,
    required this.level,
    required this.isSelected,
  });
  final String level;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.blue,
        border: Border.all(
          color: isSelected
              ? Color.fromARGB(255, 2, 39, 25)
              : Colors.transparent, // Update border color based on isSelected
          width: 4, // Border width
        ),
      ),
      width: 70,
      height: 50,
      child: Center(
        child: Text(
          level,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class drAnnonce extends StatelessWidget {
  const drAnnonce({
    super.key,
    required this.image,
    required this.nom,
    // required this.description,
    required this.nomModule,
    required this.prix,
    //required this.nbrHours,
    //required this.niveau,
    required this.onTap,
    this.widht,
    required this.availability,
  });

  final double? widht;
  final String image, nom, nomModule, prix; //nbrHours, niveau description,
  final bool availability;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.blue, width: 2),
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.002,
              width: size.width * 0.01,
            ),
            Row(
              children: [
                SizedBox(
                  height: size.height * 0.01,
                  width: size.width * 0.01,
                ),
                Container(
                  height: size.height * 0.09,
                  width: size.width * 0.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    border: Border.all(color: AppColors.blue, width: 2),
                  ),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('images/highSchool.png'),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.1,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nom,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        availability ? 'Available' : 'Not Available',
                        style: TextStyle(
                          color: availability ? Colors.green : Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.035,
                ),
                const Text(
                  'Module :',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  nomModule,
                  style: TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.035,
                ),
                const Text(
                  'Price :',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  prix + ' DA', // Concatenate "DA" after prix
                  style: TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.035,
                ),
                const Text(
                  'Number Of Hours : ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                /*Text(
                nbrHours,
                style: TextStyle(
                  color: AppColors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )*/
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: size.width * 0.035,
                ),
                const Text(
                  'Level :',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                /*  Text(
                niveau,
                style: TextStyle(
                  color: AppColors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )*/
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    print("CALL PRESSEEEEEEED");
                  },
                  child: Container(
                    child: const Center(
                      child: Text(
                        'Call',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.blue,
                    ),
                    width: size.height * 0.1,
                    height: size.width * 0.085,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.37,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.blue,
                    ),
                    width: size.height * 0.1,
                    height: size.width * 0.085,
                    child: const Center(
                      child: Text(
                        'Réserver',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.047,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
