import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/widget/ellipse_tab_indicator.dart';

import 'controller.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with SingleTickerProviderStateMixin {
  final controller = Get.find<ProjectController>();

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return LoadSir(
      onPressed: () => controller.initData(),
      isSkeleton: false,
      controller: controller,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: context.accentColor,
          titleSpacing: 0,
          title: _treeTabBar,
        ),
        body: Obx(() {
          _tabController =
              TabController(length: controller.getTreeList.length, vsync: this);
          return TabBarView(
            controller: _tabController,
            children: controller.getTreeList.map((e) {
              return Text(e.id.toString());
            }).toList(),
          );
        }),
      ),
    );
  }

  Widget get _treeTabBar => Obx(
        () {
          return TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            labelColor: Get.theme.accentColor,
            unselectedLabelColor: Get.theme.primaryColor,
            indicator: EllipseTabIndicator(),
            controller: _tabController,
            tabs: controller.getTreeList.map((e) {
              return Tab(
                text: e.name,
              );
            }).toList(),
          );
        },
      );
}
