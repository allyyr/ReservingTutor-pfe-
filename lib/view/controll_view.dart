import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sapfd/model/control_view_model.dart';
import 'package:sapfd/util/color.dart';
import 'package:sapfd/view/notification_view.dart';

// ignore: must_be_immutable
class ControlView extends StatelessWidget {
  const ControlView({super.key, required this.titre});
  final String titre;

  @override
  Widget build(BuildContext context) {
    List<String> title = [
      'Home',
      'Map',
      'Profile',
    ];
    var size = MediaQuery.of(context).size;
    return GetBuilder<ControlViewModel>(
      init: Get.put(ControlViewModel()),
      builder: (controller) => Scaffold(
        appBar: _appBar(title[controller.navigatorValue], size),
        bottomNavigationBar: _bottomNavigationBar(),
        body: controller.currentScreen,
      ),
    );
  }

  _bottomNavigationBar() {
    return GetBuilder<ControlViewModel>(
      init: Get.put(ControlViewModel()),
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
            })
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
