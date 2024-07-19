import 'package:flutter/material.dart';
import 'package:home_automation/screens/home_page.dart';
import 'package:home_automation/screens/settings_page.dart';

class BottomNavProvider extends ChangeNotifier {
  int _indexx = 0;
  int get indexx => _indexx;

  List<Widget> pages = [
    const HomePage(),
    const SettingsPage(),
  ];

  void changeTab(int index) {
    _indexx = index;
    notifyListeners();
  }
}
