import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final HomeController controller = Get.put(HomeController());

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: DefaultTabController(
        length: controller.titleList.length,
        child: TabBarView(
          children: [],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<HomeController>();
    super.dispose();
  }
}
