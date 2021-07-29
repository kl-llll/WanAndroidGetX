import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/bean/project_list_entity.dart';
import 'package:wan_android_getx/const/constants.dart';

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
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: controller.getProjectList.length,
              itemBuilder: (BuildContext context, int index) {
                ProjectListDatas data = controller.getProjectList[index];
                return Neumorphic(
                  margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10)),
                      depth: 4,
                      lightSource: LightSource.topLeft,
                      color: context.primaryColor),
                  child: Container(
                    color: Get.theme.primaryColor,
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          height: 150.h,
                          width: double.maxFinite,
                          imageUrl: data.envelopePic!,
                          placeholder: (context, url) => LoadingState(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 5.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              titleText(data.title!),
                              SizedBox(
                                height: 5.h,
                              ),
                              secondText(
                                  data.shareUser!.isEmpty? data.author!: data.shareUser!)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
            ));
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
