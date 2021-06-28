import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:wan_android_getx/const/colors.dart';
import 'package:wan_android_getx/utils/toast_util.dart';

import 'home/page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage1State createState() => _MainPage1State();
}

class _MainPage1State extends State<MainPage> {
  late PageController _pageController;
  late PersistentTabController _controller;

  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home,size: 20),
        title: "首页",
        activeColorPrimary: ResourceColors.adaptiveDefaultColor,
        inactiveColorPrimary: ResourceColors.adaptiveSecondColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(IconData(0xe64f,fontFamily: "IconFont"),size: 23,),
        title: "公众号",
        activeColorPrimary: ResourceColors.adaptiveDefaultColor,
        inactiveColorPrimary: ResourceColors.adaptiveSecondColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.circle_grid_3x3,size: 20),
        title: "体系",
        activeColorPrimary: ResourceColors.adaptiveDefaultColor,
        inactiveColorPrimary: ResourceColors.adaptiveSecondColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.book,size: 20),
        title: "项目",
        activeColorPrimary: ResourceColors.adaptiveDefaultColor,
        inactiveColorPrimary: ResourceColors.adaptiveSecondColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person,size: 20),
        title: "我的",
        activeColorPrimary: ResourceColors.adaptiveDefaultColor,
        inactiveColorPrimary: ResourceColors.adaptiveSecondColor,
      ),
    ];
  }

  Widget _persistentTabView() {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: ResourceColors.adaptiveBackgroundColor,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      onWillPop: (context)=>_isExit(),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property.
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
        child: _persistentTabView(),
        // WillPopScope(
        //   onWillPop: _isExit,
        //   child: PageView(
        //     physics: NeverScrollableScrollPhysics(),
        //     children: _buildScreens,
        //     controller: _pageController,
        //   ),
        // ),
      ),
      // bottomNavigationBar: _persistentTabView(),
    );
  }
}
