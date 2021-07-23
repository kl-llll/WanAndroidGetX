import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/modules/home/hot/controller.dart';
import 'package:wan_android_getx/widget/article_item.dart';
import 'package:wan_android_getx/widget/custom_app_bar.dart';
import 'package:wan_android_getx/widget/load_sir.dart';

import 'controller.dart';

class CollectPage extends StatelessWidget {
  final controller = Get.find<CollectController>();
  final hotController = Get.find<HotController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "收藏列表", elevation: 1),
      body: LoadSir(
        onPressed: () => controller.initData(),
        controller: controller,
        child: SmartRefresher(
          controller: controller.refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () => controller.refresh(),
          onLoading: () => controller.loadMore(),
          child: Obx(() {
            return ListView.builder(
              itemBuilder: (c, i) {
                return ArticleItem(
                    context: context,
                    data: controller.getCollectList[i],
                    controller: hotController);
              },
              itemCount: controller.getCollectList.length,
            );
          }),

        ),
      ),
    );
  }
}
