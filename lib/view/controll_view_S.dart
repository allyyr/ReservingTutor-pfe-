import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sapfd/util/color.dart';
import 'package:sapfd/view/map_home_view.dart';
import 'package:sapfd/view/notification_view.dart';
import 'package:sapfd/view/profile_home_view.dart';

import 'homeScreenPage.dart';

// ignore: must_be_immutable
class ControlView_S extends StatelessWidget {
  const ControlView_S({
    super.key,
    required this.titre,
  });
  final String titre;

  @override
  Widget build(BuildContext context) {
    List<String> title = [
      'Home',
      'Map',
      'Profile',
    ];
    var size = MediaQuery.of(context).size;
    return GetBuilder<ControlViewModel_S>(
      init: Get.put(ControlViewModel_S()),
      builder: (controller) => Scaffold(
        appBar: _appBar(title[controller.navigatorValue], size),
        bottomNavigationBar: _bottomNavigationBar(),
        body: controller.currentScreen,
      ),
    );
  }

  _bottomNavigationBar() {
    return GetBuilder<ControlViewModel_S>(
      init: Get.put(ControlViewModel_S()),
      builder: (controller) => BottomNavigationBar(
        currentIndex: controller.navigatorValue,
        onTap: (value) {
          controller.changeSelectedValue(value);
        },
        selectedItemColor: AppColors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_2_sharp), label: ''),
        ],
      ),
    );
  }

  _appBar(String title, Size taille) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: taille.height * 0.10,
      centerTitle: false,
      actions: [
        FloatingActionButton(
            heroTag: null,
            elevation: 0,
            backgroundColor: AppColors.blue,
            child: const Icon(
              Icons.notification_important,
              color: Colors.white,
            ),
            onPressed: () {
              Get.to(const Notification_view());
            }),
        /*   IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.exit_to_app)) */
      ],
      backgroundColor: AppColors.blue,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class ControlViewModel_S extends GetxController {
  int _navigatorValue = 0;

  Widget _currentScreen = const homeScreenPage();
  get currentScreen => _currentScreen;
  get navigatorValue => _navigatorValue;

  void changeSelectedValue(
    int selectedValue,
  ) {
    _navigatorValue = selectedValue;

    // For other user roles, switch between all 3 cases
    switch (selectedValue) {
      case 0:
        {
          _currentScreen = const homeScreenPage();
          break;
        }
      case 1:
        {
          _currentScreen = const CityMap();
          break;
        }
      case 2:
        {
          _currentScreen = ProfileHomeView();
          break;
        }
    }
    update();
  }
}
