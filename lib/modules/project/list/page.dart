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
      loadType: LoadType.PROJECT,
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
                HomeArticleDatas data = controller.getProjectList[index];
                return GestureDetector(
                  onTap: ()=>Get.toNamed(Routes.WEB, arguments: {"url": data.link}),
                  child: Neumorphic(
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
                              child: transparentLikeButton(
                                  context, data, controller),
                            ),
                            Positioned(
                              child: _buildNiceDate(data),
                            )
                          ]),
                          Divider(height: 1,color: AppColors.secondColor,),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    secondText(data.shareUser!.isEmpty
                                        ? "作者:${data.author!}"
                                        : "分享人:${data.shareUser!}"),
                                    Row(
                                      children: buildTagWidget(data),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
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

  Container _buildNiceDate(HomeArticleDatas data) {
    return Container(
      alignment: Alignment.center,
      // width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Get.theme.accentColor, Colors.transparent]),
      ),
      child: Text(data.niceDate!,
          style: TextStyle(
              fontSize: 14.sp,
              color: Get.theme.primaryColor,
              fontWeight: FontWeight.w500)),
    );
  }

  Widget transparentLikeButton(BuildContext context, HomeArticleDatas data,
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
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 4,
                      sigmaY: 4,
                    ),
                    child: Container(),
                  ),
                ),
              ),
              Container(
                width: 45.r,
                height: 45.r,
              ),
            ],
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

  List<Widget> buildTagWidget(HomeArticleDatas data) {
    List<Widget> widgetList = [];

    tagWidget(String text) => Neumorphic(
          style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
            depth: 1,
            lightSource: LightSource.topLeft,
            color: text.isNotEmpty
                ? AppColors.secondColor
                : AppColors.collocationColor,
          ),
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
          child: Container(
            child: topText(text),
          ),
        );

    data.tags!.forEach((element) {
      widgetList.add(tagWidget(element.name!));
    });

    return widgetList;
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
