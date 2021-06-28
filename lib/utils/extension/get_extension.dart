import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/const/colors.dart';

extension GetExtension on GetInterface {

  void showCustomSnackbar(String msg, {String title = "提示"}) {
    var color = ResourceColors.adaptiveDefaultColor;
    Get.snackbar(title, msg, colorText: color);
  }

  void showErrorSnackbar(String msg, {String title = "错误提示"}) {
    Get.snackbar(title, msg, colorText: Colors.red);
  }

}
