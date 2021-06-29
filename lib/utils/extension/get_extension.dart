import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/const/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension GetExtension on GetInterface {
  void showCustomSnackbar(String msg, {String title = "提示"}) {
    Get.snackbar(
      title,
      msg,
      colorText: Theme.of(context!).backgroundColor,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Theme.of(context!).primaryColor.withAlpha(180),
      margin: EdgeInsets.only(left: 10.w,right: 10.w)
    );
  }

  void showErrorSnackbar(String msg, {String title = "错误提示"}) {
    Get.snackbar(title, msg,
        colorText: Colors.red, snackPosition: SnackPosition.BOTTOM);
  }
}
