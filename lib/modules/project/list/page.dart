import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/const/constants.dart';

import 'controller.dart';

class ListPage extends StatefulWidget {
  final int cId;

  const ListPage({ required this.cId}) ;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final controller = Get.find<ListController>();

  @override
  void initState() {
    super.initState();
    controller.cId = widget.cId;
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
              return Text(controller.getProjectList[index].title!);
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
