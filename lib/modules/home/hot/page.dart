import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/const/constants.dart';

import 'controller.dart';

class HotPage extends StatefulWidget {
  @override
  _HotPageState createState() => _HotPageState();
}

class _HotPageState extends State<HotPage> with AutomaticKeepAliveClientMixin {
  final controller = Get.put(HotController());

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Obx(() {
      // print(controller.loadState);

      return StatePageWithViewController<HotController>(
        controller: controller.refreshController,
        model: controller,
        onPressed: () => controller.getData(),
        onRefresh: () => controller.getData(),
        onLoading: () => controller.getData(),
        child: ListView.builder(
          itemBuilder: (c, i) => Card(
              child: Center(
                  child: Text("${controller.homeArticleList[i].chapterName}"))),
          itemCount: controller.homeArticleList.length,
        ),
      );
    });


  }

  @override
  void dispose() {
    Get.delete<HotController>();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
