import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/modules/home/hot/controller.dart';
import 'package:wan_android_getx/widget/article_item.dart';

import 'controller.dart';

class SquarePage extends StatefulWidget {
  @override
  _SquarePageState createState() => _SquarePageState();
}

class _SquarePageState extends State<SquarePage>
    with AutomaticKeepAliveClientMixin {
  final controller = Get.find<SquareController>();
  final hotController = Get.put(HotController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoadSir(
      onPressed: () => controller.initData(),
      controller: controller,
      child: Obx(() {
        return SmartRefresher(
          controller: controller.refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () => controller.refresh(),
          onLoading: () => controller.loadMore(),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ArticleItem(
                  context: context,
                  data: controller.getSquareList[index],
                  controller: hotController);
            },
            itemCount: controller.getSquareList.length,
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    Get.delete<SquareController>();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
