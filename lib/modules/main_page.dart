import 'package:flutter/material.dart';
import 'package:wan_android_getx/utils/toast_util.dart';

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

  DateTime? _lastTime;

  Future<bool> _isExit() async {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime!) > Duration(milliseconds: 1000)) {
      _lastTime = DateTime.now();
      showToast("在按一次退出应用");
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: _isExit,
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            children: _pages,
            controller: _pageController,
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigation(),
    );
  }
}
