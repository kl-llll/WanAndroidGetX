import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/const/constants.dart';

import 'controller.dart';

class MinePage extends StatelessWidget {
  final MineController controller = Get.put(MineController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          CachedNetworkImage(
            height: 250.h,
            imageUrl: controller.getImageSrc,
            placeholder: (context, url) => LoadingState(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    buildGaussianBlur(context),
                    buildLevelTag(context),
                  ],
                ),
                Expanded(
                  child: Stack(children: [
                    Container(
                      margin: EdgeInsets.only(top: 80.h),
                      // height: 300.h,
                      decoration: BoxDecoration(
                        color: context.primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    Neumorphic(
                      margin:
                          EdgeInsets.symmetric(horizontal: 30.w, vertical: 55.h),
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(30)),
                          depth: 2,
                          lightSource: LightSource.topLeft,
                          color: context.primaryColor),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        height: 35.h,
                        decoration: BoxDecoration(
                          color: context.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          )
        ],
      );
    });
  }

  Neumorphic buildLevelTag(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        depth: 1.5,
        lightSource: LightSource.bottomRight,
      ),
      child: Container(
        alignment: Alignment.center,
        height: 18.h,
        width: 40.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0, 0.9],
              colors: [context.accentColor, AppColors.secondColor]),
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
                "113",
                style: TextStyle(color: context.primaryColor, fontSize: 12.sp),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildGaussianBlur(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 70.h, bottom: 5.h),
      child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.circle(),
            depth: 3,
            lightSource: LightSource.top,
            color: Colors.transparent),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4)),
              height: 80.r,
              width: 80.r,
            ),
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 1,
                    sigmaY: 1,
                  ),
                  child: Container(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
