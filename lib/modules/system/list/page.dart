import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/modules/home/hot/controller.dart';
import 'package:wan_android_getx/widget/article_item.dart';
import 'package:wan_android_getx/widget/custom_app_bar.dart';

import 'controller.dart';

class ListPage extends GetView<ListController> {
  final hotController = Get.put(HotController());

  @override
  Widget build(BuildContext context) {
    return LoadSir(
      onPressed: () => controller.initData(),
      controller: controller,
      child: Obx(() {
        return Scaffold(
          appBar: customAppBar(title: controller.title.value,elevation: 1),
          body: SmartRefresher(
            controller: controller.refreshController,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: () => controller.refresh(),
            onLoading: () => controller.loadMore(),
            child: ListView.builder(
              itemBuilder: (context, index) {
                // return Container();
                return ArticleItem(
                    context: context,
                    data: controller.getSystemList[index],
                    controller: hotController);
              },
              itemCount: controller.getSystemList.length,
            ),
          ),
        );
      }),
    );
  }
}
