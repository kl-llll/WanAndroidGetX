import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/widget/custom_app_bar.dart';
import 'package:wan_android_getx/widget/load_sir.dart';

import 'controller.dart';

class RankPage extends StatelessWidget {
  final controller = Get.find<RankController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "排行榜", elevation: 1),
      body: LoadSir(
        onPressed: () => controller.initData(),
        controller: controller,
        isSkeleton: false,
        child: SmartRefresher(
          controller: controller.refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () => controller.refresh(),
          onLoading: () => controller.loadMore(),
          child: CustomScrollView(
            slivers: [
              _buildTopRank(context),
              Obx(
                () {
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      controller.getRankList
                          .getRange(3, controller.getRankList.length)
                          .map((e) {
                        return Column(
                          children: [
                            Divider(
                              height: 1,
                            ),
                            ListTile(
                              title: titleText(e.username.toString()),
                              subtitle: secondText("积分:${e.coinCount.toString()}"),
                              leading: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Text(
                                  e.rank.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21.sp,
                                      color: context.accentColor),
                                ),
                              ),
                              trailing:
                                  _buildLevelTag(context, e.level.toString()),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Neumorphic _buildLevelTag(BuildContext context, String level) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        depth: 1,
        lightSource: LightSource.bottomRight,
      ),
      child: Container(
        alignment: Alignment.center,
        height: 18.h,
        width: 45.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0,
                0.9
              ],
              colors: [
                AppColors.secondColor,
                context.accentColor,
              ]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              R.ASSETS_IMAGES_LEVEL_SVG,
              color: context.primaryColor,
              height: 12.r,
              width: 12.r,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Text(
                level,
                style: TextStyle(color: context.primaryColor, fontSize: 12.sp),
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildTopRank(BuildContext context) {
    Padding _buildUserName(
        BuildContext context, String userName, String integral) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 3.h),
        child: Neumorphic(
          style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              depth: 1,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
              lightSource: LightSource.bottomRight,
              color: Colors.transparent),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 2,
                      sigmaY: 2,
                    ),
                    child: Container(),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
                child: Text(
                  userName,
                  style: TextStyle(color:Get.theme.accentColor,fontSize: 18.sp,fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Column _rank123(BuildContext context, String svg, String level,
        String username, String integral, bool isFirst) {
      return Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SvgPicture.asset(
                svg,
                width: isFirst ? 140.r : 100.r,
                height: isFirst ? 140.r : 100.r,
              ),
              Positioned(
                bottom: isFirst ? 20.h : 15.h,
                child: _buildLevelTag(context, level),
              )
            ],
          ),
          _buildUserName(context, username, integral),
        ],
      );
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _rank123(
                  context,
                  R.ASSETS_IMAGES_RANK2_SVG,
                  controller.getRankList[1].level.toString(),
                  controller.getRankList[1].username.toString(),
                  controller.getRankList[1].coinCount.toString(),
                  false),
              _rank123(
                  context,
                  R.ASSETS_IMAGES_RANK1_SVG,
                  controller.getRankList[0].level.toString(),
                  controller.getRankList[0].username.toString(),
                  controller.getRankList[0].coinCount.toString(),
                  true),
              _rank123(
                  context,
                  R.ASSETS_IMAGES_RANK3_SVG,
                  controller.getRankList[2].level.toString(),
                  controller.getRankList[2].username.toString(),
                  controller.getRankList[2].coinCount.toString(),
                  false),
            ],
          );
        }),
      ),
    );
  }
}
