import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/modules/home/hot/controller.dart';
import 'package:wan_android_getx/widget/article_item.dart';
import 'package:wan_android_getx/widget/load_sir.dart';

import 'controller.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage>
    with AutomaticKeepAliveClientMixin {
  final controller = Get.find<QuestionController>();

  final hotController = Get.put(HotController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      return LoadSir(
        onPressed: () => controller.initData(),
        controller: controller,
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
                  data: controller.getSquareList[index],
                  controller: hotController);
            },
            itemCount: controller.getSquareList.length,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    Get.delete<QuestionController>();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
