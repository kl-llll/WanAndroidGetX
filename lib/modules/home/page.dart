import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:wan_android_getx/modules/home/hot/page.dart';
import 'package:wan_android_getx/modules/home/question/page.dart';
import 'package:wan_android_getx/modules/home/square/page.dart';
import 'package:wan_android_getx/utils/log_util.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> titleList = ["广场", "热门", "问答"];
  var _searchBarController = Get.find<FloatingSearchBarController>();

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: titleList.length, vsync: this, initialIndex: 1);
  }

  PreferredSizeWidget? _buildTabBar() {
    return PreferredSize(
      child: Container(
        height: 70.h,
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 10.h,
            left: 30.w,
            right: 30.w,
            bottom: 5.h),
        child: Stack(
          children: [
            Neumorphic(
              style: NeumorphicStyle(
                border: NeumorphicBorder(
                  color: Colors.white38,
                  width: 0.1,
                ),
                shape: NeumorphicShape.convex,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                depth: -1.5,
                lightSource: LightSource.topLeft,
                color: Theme.of(context).primaryColor,
                intensity: 0.8,
              ),
              child: Container(),
            ),
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Theme.of(context).primaryColor,
              labelStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              unselectedLabelColor: Colors.white.withAlpha(180),
              unselectedLabelStyle: TextStyle(fontSize: 13.sp),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 8,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              controller: _tabController,
              tabs: titleList.map((e) {
                return Tab(
                  text: e,
                );
              }).toList(),
            ),
          ],
        ),
      ),
      preferredSize: Size(double.infinity, 150.h),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: EdgeInsets.only(top: 16.h, bottom: 56.h),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      borderRadius: BorderRadius.circular(20),
      controller: _searchBarController,
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
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
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: _buildTabBar(),
        body: Stack(children: [
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: TabBarView(
              controller: _tabController,
              children: [SquarePage(), HotPage(), QuestionPage()],
            ),
          ),
          buildFloatingSearchBar(),
        ]),
      ),
    );
  }
}
