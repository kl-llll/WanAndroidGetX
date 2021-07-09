import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

titleText(String text) {
  return Text(text,
      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold));
}

secondText(String text) {
  return Text(text,
      style: TextStyle(fontSize: 12.sp, color: Get.textTheme.bodyText1!.color));
}

topText(String text) {
  return Text(text, style: TextStyle(fontSize: 12.sp, color: Colors.white));
}
