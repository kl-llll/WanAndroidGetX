import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:wan_android_getx/modules/home/hot/page.dart';
import 'package:wan_android_getx/modules/home/question/page.dart';
import 'package:wan_android_getx/modules/home/square/page.dart';
import 'package:wan_android_getx/const/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var searchBarController = Get.find<FloatingSearchBarController>();

  late TabController _tabController;
  final List<String> _titleList = ["广场", "热门", "问答"];
  final List<Widget> _pageList = [SquarePage(), HotPage(), QuestionPage()];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _titleList.length, vsync: this, initialIndex: 1);
  }

  AppBar get _buildTabBar {
    return AppBar(
      brightness: Brightness.dark,
      backgroundColor: context.accentColor,
      title: Row(
        children: [
          Container(
            height: 35.h,
            width: 230.w,
            child: Stack(
              children: [
                _neumorphic,
                _topTabBar,
              ],
            ),
          ),
          _openSearch,
        ],
      ),
    );
  }

  GestureDetector get _openSearch {
    return GestureDetector(
      onTap: () {
        if (!searchBarController.isVisible) {
          searchBarController.show();
          searchBarController.open();
        }
      },
      child: Neumorphic(
        margin: EdgeInsets.only(left: 13.w),
        style: NeumorphicStyle(
            shape: NeumorphicShape.convex,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
            depth: 1.5,
            lightSource: LightSource.topLeft,
            color: context.canvasColor,
            intensity: 0.5,
            surfaceIntensity: 0.3),
        child: Container(
          alignment: Alignment.center,
          width: 85.w,
          height: 35.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("123"),
              Icon(
                CupertinoIcons.search,
                color: context.accentColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TabBar get _topTabBar {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: context.accentColor,
      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
      unselectedLabelColor: Colors.white.withAlpha(180),
      unselectedLabelStyle: TextStyle(fontSize: 13.sp),
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: context.canvasColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 8,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      controller: _tabController,
      tabs: _titleList.map((e) {
        return Tab(
          text: e,
        );
      }).toList(),
    );
  }

  Neumorphic get _neumorphic {
    return Neumorphic(
      style: NeumorphicStyle(
        border: NeumorphicBorder(
          color: Colors.white38,
          width: 0.1,
        ),
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
        depth: -1.5,
        lightSource: LightSource.topLeft,
        color: context.accentColor,
        intensity: 0.8,
      ),
      child: Container(),
    );
  }

  Widget get buildFloatingSearchBar {
    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: EdgeInsets.only(top: 16.h, bottom: 35.h),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      openAxisAlignment: 0.0,
      debounceDelay: const Duration(milliseconds: 500),
      borderRadius: BorderRadius.circular(15),
      showAfter: Duration(days: 999),
      controller: searchBarController,
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      onFocusChanged: (focus) {
        if (!focus) {
          searchBarController.close();
          searchBarController.hide();
        }
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: true,
          child: CircularButton(
            icon: Icon(
              CupertinoIcons.search,
              color: context.accentColor,
            ),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction(
          showIfOpened: true,
          child: CircularButton(
            icon: Icon(
              CupertinoIcons.clear,
              color: context.accentColor,
            ),
            onPressed: () {
              searchBarController.close();
              searchBarController.hide();
            },
          ),
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          Scaffold(
            appBar: _buildTabBar,
            body: TabBarView(
              controller: _tabController,
              children: _pageList,
            ),
          ),
          buildFloatingSearchBar,
        ],
      ),
    );
  }
}
