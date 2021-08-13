import 'package:flutter/material.dart';
import 'package:wan_android_getx/const/constants.dart';

import 'app_bar_icon.dart';

AppBar customAppBar({required String title, double elevation = 0}) {
  return AppBar(
    backgroundColor: Get.theme.canvasColor,
    elevation: elevation,
    leading: Container(
      padding: EdgeInsets.all(12.r),
      child: AppBarIcon(),
    ),
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(color: Get.theme.accentColor, fontSize: 19.sp),
    ),
  );
}

