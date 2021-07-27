import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/bean/project_list_entity.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/modules/project/list/page.dart';
import 'package:wan_android_getx/widget/circle_tab_indicator.dart';

import 'controller.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with SingleTickerProviderStateMixin {
  final controller = Get.find<ProjectController>();

  @override
  void initState() {
    super.initState();
    controller.requestProjectTree(this);
  }

  @override
  Widget build(BuildContext context) {
    return LoadSir(
      onPressed: () => controller.requestProjectTree(this),
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
          return TabBarView(
            controller: controller.tabController,
            children: controller.getTreeList.map((e) {
              return new ListPage(cId: e.id!);
            }).toList(),
          );
        }),
      ),
    );
  }

  Widget get _treeTabBar => Obx(() {
        return TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          labelColor: Get.theme.primaryColor,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          unselectedLabelColor: Get.theme.primaryColor,
          unselectedLabelStyle: TextStyle(fontSize: 14.sp),
          indicator:
              CircleTabIndicator(color: Get.theme.primaryColor, radius: 2.5),
          controller: controller.tabController,
          tabs: controller.getTreeList.map(
            (e) {
              return Tab(
                text: e.name,
              );
            },
          ).toList(),
        );
      });
}
