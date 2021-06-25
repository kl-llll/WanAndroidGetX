import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/modules/login/page.dart';

import 'home/page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage1State createState() => _MainPage1State();
}

class _MainPage1State extends State<MainPage> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  final _tabs = [
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "登录"),
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "首页"),
  ];

  final List<Widget> _pages = [
    HomePage(),
    HomePage(),
  ];

  Widget _bottomNavigation() {
    return BottomNavigationBar(
      items: _tabs,
      currentIndex: _pageIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _pageIndex = index;
          _pageController.jumpToPage(_pageIndex);
        });
      },
    );
  }

  int _lastWantToPop = 0;

  Future<bool> doubleBackExit() async {
    final int now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastWantToPop > 800) {
      Get.snackbar("提示", '再按一次退出应用');
      _lastWantToPop = DateTime.now().millisecondsSinceEpoch;
      return false;
    } else {
      Get.back();
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigation(),
      body: WillPopScope(
        onWillPop: doubleBackExit,
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: _pages,
          controller: _pageController,
        ),
      ),
    );
  }
}
