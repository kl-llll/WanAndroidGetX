import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/modules/home/hot/controller.dart';
import 'package:wan_android_getx/widget/article_item.dart';
import 'package:wan_android_getx/widget/custom_app_bar.dart';

import 'controller.dart';

class ListPage extends StatefulWidget {
  final int cId;

  const ListPage({required this.cId});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late ListController controller;

  final hotController = Get.put(HotController());

  @override
  void initState() {
    super.initState();
    controller = Get.find<ListController>(tag: widget.cId.toString());
  }

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
              // return Container();
              return ArticleItem(
                  context: context,
                  data: controller.getProjectList[index],
                  controller: hotController);
            },
            itemCount: controller.getProjectList.length,
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    Get.delete<ListController>();
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
