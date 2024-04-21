import 'package:flutter/material.dart';
import 'package:sapfd/util/color.dart';
import 'package:sapfd/util/custom_element.dart';

class highSchool extends StatelessWidget {
  const highSchool({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.blue,
        title: const Text(
          'High School',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.009,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              GestureDetector(
                onTap: () {},
                child: const chooseLevel(
                  level: '1AS',
                  isSelected: false,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const chooseLevel(
                  level: '2AS',
                  isSelected: false,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const chooseLevel(
                  level: '3AS',
                  isSelected: false,
                ),
              ),
              const Divider(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: size.height * 0.03,
                  width: size.height * 0.04,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                  ),
                  child: Icon(
                    Icons.filter_none,
                    color: AppColors.blue,
                  ),
                ),
              ),
              const SizedBox(),
            ],
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          const Divider(),
          SizedBox(
            width: size.width * 0.9,
            height: size.height * 0.794,
            child: GridView.count(
              childAspectRatio: 1.38,
              mainAxisSpacing: 15,
              crossAxisCount: 1,
              children: [
                for (int i = 0; i < 10; i++)
                  drAnnonce(
                    onTap: () {},
                    image: 'images/highSchool.png',
                    nom: 'Taleb salaheddine',
                    nomModule: 'Math',
                    availability: false,

                    prix: '2000 DA',
                    //    nbrHours: '8',
                    //  niveau: '4AP'
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
