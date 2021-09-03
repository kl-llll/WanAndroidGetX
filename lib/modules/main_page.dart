import 'package:flutter/cupertino.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/modules/mine/page.dart';
import 'package:wan_android_getx/modules/project/page.dart';
import 'package:wan_android_getx/modules/system/page.dart';
import 'package:wan_android_getx/modules/wx/page.dart';

import 'home/page.dart';
import 'login/page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage1State createState() => _MainPage1State();
}

class _MainPage1State extends State<MainPage> {
  late PersistentTabController _controller;
  var _searchBarController = Get.find<FloatingSearchBarController>();

  final List<String> _bottomNavBatTitle = ["首页", "项目", "体系", "公众号", "我的"];
  final List<Icon> _bottomNavBatIcon = [
    Icon(CupertinoIcons.home, size: 20),
    Icon(CupertinoIcons.book, size: 20),
    Icon(CupertinoIcons.circle_grid_3x3, size: 20),
    Icon(IconData(0xe64f, fontFamily: "IconFont"), size: 23),
    Icon(CupertinoIcons.person, size: 20),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> get _buildScreens {
    return [
      HomePage(),
      ProjectPage(),
      SystemPage(),
      WXPage(),
      MinePage(),
    ];
  }

  List<PersistentBottomNavBarItem> get _navBarsItems {
    List<PersistentBottomNavBarItem> _navBarsItemList = [];
    _bottomNavBatTitle.asMap().forEach((key, value) {
      _navBarsItemList
          .add(_navBarsItem(icon: _bottomNavBatIcon[key], title: value));
    });
    return _navBarsItemList;
  }

  PersistentBottomNavBarItem _navBarsItem({
    required Icon icon,
    required String title,
  }) {
    return PersistentBottomNavBarItem(
      icon: icon,
      title: title,
      activeColorPrimary: context.accentColor,
      inactiveColorPrimary: context.iconColor,
    );
  }

  Widget get _persistentTabView {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens,
      items: _navBarsItems,
      navBarHeight: 45.h,
      padding: NavBarPadding.only(left: 35.w, right: 35.w, bottom: 10.h),
      confineInSafeArea: true,
      // backgroundColor: ResourceColors.adaptiveBackgroundColor,
      backgroundColor: context.canvasColor,
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
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          colorBehindNavBar: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0.5), //x,y轴
                color: context.shadowColor, //投影颜色
                blurRadius: 1 //投影距离
                )
          ]),
      onWillPop: (context) => _isExit,
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

  Future<bool> get _isExit async {
    if (_searchBarController.isClosed) {
      if (_lastTime == null ||
          DateTime.now().difference(_lastTime!) >
              Duration(milliseconds: 1000)) {
        _lastTime = DateTime.now();
        showToast("在按一次退出应用");
        return Future.value(false);
      } else {
        return Future.value(true);
      }
    } else {
      _searchBarController.close();
      _searchBarController.hide();
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _persistentTabView;
  }
}
