import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapfd/view/homeScreenPage.dart';
import 'package:sapfd/view/map_home_view.dart';
import 'package:sapfd/view/profile_home_view.dart';

class ControlViewModel extends GetxController {
  int _navigatorValue = 0;
  Widget _currentScreen = const homeScreenPage();
  get currentScreen => _currentScreen;
  get navigatorValue => _navigatorValue;

  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        {
          _currentScreen = const homeScreenPage();
          break;
        }
      case 1:
        {
          _currentScreen = const MapHomeView();
          break;
        }
      case 2:
        {
          _currentScreen =  ProfileHomeView();
          
          break;
        }
    }
    update();
  }
}
