import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:wan_android_getx/const/colors.dart';
import 'package:wan_android_getx/utils/toast_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'home/page.dart';
import 'login/page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage1State createState() => _MainPage1State();
}

class _MainPage1State extends State<MainPage> {
  late PersistentTabController _controller;
  var _searchBarController = Get.find<FloatingSearchBarController>();

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      LoginPage(),
      LoginPage(),
      LoginPage(),
      LoginPage(),

    ];
  }

  // LoginPage(),

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home, size: 20),
        title: "首页",
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: ResourceColors.adaptiveSecondColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          IconData(0xe64f, fontFamily: "IconFont"),
          size: 23,
        ),
        title: "公众号",
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: ResourceColors.adaptiveSecondColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.circle_grid_3x3, size: 20),
        title: "体系",
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: ResourceColors.adaptiveSecondColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.book, size: 20),
        title: "项目",
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: ResourceColors.adaptiveSecondColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person, size: 20),
        title: "我的",
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: ResourceColors.adaptiveSecondColor,
      ),
    ];
  }

  Widget _persistentTabView() {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarHeight: 45.h,
      padding: NavBarPadding.only(left: 35.w, right: 35.w, bottom: 10.h),
      confineInSafeArea: true,
      // backgroundColor: ResourceColors.adaptiveBackgroundColor,
      backgroundColor: Theme.of(context).cardColor,
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
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          colorBehindNavBar: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0.5), //x,y轴
                color: Theme.of(context).primaryColorDark, //投影颜色
                blurRadius: 1 //投影距离
                )
          ]),
      onWillPop: (context) => _isExit(),
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

    if(_searchBarController.isClosed){
      if (_lastTime == null ||
          DateTime.now().difference(_lastTime!) > Duration(milliseconds: 1000)) {
        _lastTime = DateTime.now();
        showToast("在按一次退出应用");
        return Future.value(false);
      } else {
        return Future.value(true);
      }
    }else{
      _searchBarController.close();
      return Future.value(false);
    }

  }

  @override
  Widget build(BuildContext context) {
    return _persistentTabView();
  }
}
