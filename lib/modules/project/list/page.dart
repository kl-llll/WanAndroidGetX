import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
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
                        Container(
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: [
                                  0,
                                  0.4
                                ],
                                colors: [
                                  AppColors.secondColor.withAlpha(200),
                                  context.accentColor
                                ]),
                          ),
                          child: Text(data.niceDate!,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Get.theme.primaryColor)),
                        ),
                        Stack(children: [
                          CachedNetworkImage(
                            height: 150.h,
                            width: double.maxFinite,
                            imageUrl: data.envelopePic!,
                            placeholder: (context, url) => LoadingState(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.fitWidth,
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: transparentLikeButton(context, data, controller),
                          ),
                        ]),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 5.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              titleText(data.title!),
                              SizedBox(
                                height: 5.h,
                              ),
                              secondText(data.desc!),
                              SizedBox(
                                height: 5.h,
                              ),
                              secondText(data.shareUser!.isEmpty
                                  ? "作者:${data.author!}"
                                  : "分享人:${data.shareUser!}"),
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

  Widget transparentLikeButton(BuildContext context, ProjectListDatas data,
      BaseGetXController controller) {
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      final bool success;
      if (isLiked) {
        success = await controller.unCollect(data.id!, null);
      } else {
        success = await controller.collect(data.id!);
      }
      return success ? !isLiked : isLiked;
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Neumorphic(
          style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.circle(),
              depth: 2,
              lightSource: LightSource.topLeft,
              color: Colors.transparent),
          child: Container(
            width: 45.r,
            height: 45.r,
          ),
        ),
        LikeButton(
          onTap: onLikeButtonTapped,
          size: 30.r,
          likeCountPadding: EdgeInsets.zero,
          isLiked: data.collect,
          circleColor: CircleColor(
              start: AppColors.secondColor.withAlpha(100),
              end: AppColors.secondColor),
          bubblesColor: BubblesColor(
            dotPrimaryColor: AppColors.secondColor.withAlpha(100),
            dotSecondaryColor: AppColors.secondColor,
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              CupertinoIcons.heart_fill,
              color: isLiked ? AppColors.secondColor : context.iconColor,
              size: 30.r,
            );
          },
        )
      ],
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
