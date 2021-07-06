import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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

    return Obx(
      () {
        return Scaffold(
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            controller: controller.refreshController,
            onRefresh: controller.getData,
            // onLoading: controller.getData,
            child: controller.homeArticleList.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (c, i) => Card(
                        child: Center(
                            child: Text(
                                "${controller.homeArticleList[i].chapterName}"))),
                    itemExtent: 100.0,
                    itemCount: controller.homeArticleList.length,
                  )
                : LoadingState(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    Get.delete<HotController>();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
