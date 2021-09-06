import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/const/hive_boxes.dart';
import 'package:wan_android_getx/modules/home/hot/controller.dart';
import 'package:wan_android_getx/widget/article_item.dart';

import 'controller.dart';

class SearchPage extends StatelessWidget {
  final controller = Get.find<SearchController>();

  final hotController = Get.put(HotController());

  @override
  Widget build(BuildContext context) {
    return LoadSir(
      onPressed: () => controller.initData(),
      controller: controller,
      child: Obx(() {

        // TODO:用Hive存储历史搜索关键词

        return Container(
          height: 550.h,
          color: context.canvasColor,
          child: SmartRefresher(
            controller: controller.refreshController,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: () => controller.refresh(),
            onLoading: () => controller.loadMore(),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ArticleItem(
                    context: context,
                    data: controller.getSearchList[index],
                    controller: hotController);
              },
              itemCount: controller.getSearchList.length,
            ),
          ),
        );
      }),
    );
  }

  Widget historySearch() {
    Widget item() {
      return Column(
        children: [
          Text("热门搜索"),
        ],
      );
    }

    return Column();
  }
}
