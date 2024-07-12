

import 'package:flutter/material.dart';

import '../../widget/app-bar-widget.dart';
import '../base-vm.dart';
import 'home/home.ui.dart';

class BottomNavigationViewModel extends BaseViewModel {


  init({int? initialIndex})async{
    selectedPage = initialIndex??0;
    notifyListeners();
    appCache.initialIndex = selectedPage;
  }


  int selectedPage = 0;

  void onNavigationItem(index) {
    selectedPage = index;
    notifyListeners();
  }

  List<Widget> screens = [
    const HomeView(),
    Scaffold(
      backgroundColor: Colors.orange,
    ),
    Scaffold(
      backgroundColor: Colors.green,
    ),

  ];
}