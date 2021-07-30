import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wan_android_getx/utils/extension/string_extension.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' show parse;

appBarText(String text) {
  return Text(text,
      style: TextStyle(color: Get.theme.accentColor, fontSize: 19.sp));
}

titleText(String text) {
  return Text(
    parse(parse(text).body!.text).documentElement!.text.overflow,
    // text,
    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold,height: 1.1),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );
}

secondText(String text) {
  return Text(
    parse(parse(text).body!.text).documentElement!.text.overflow,
    style: TextStyle(fontSize: 12.sp, color: Get.textTheme.bodyText1!.color,height: 1.1),
    maxLines: 3,
    overflow: TextOverflow.ellipsis,
  );
}

thirdText(String text) {
  return Text(text,
      style: TextStyle(fontSize: 11.sp, color: Get.textTheme.bodyText1!.color));
}

topText(String text) {
  return Text(text, style: TextStyle(fontSize: 12.sp, color: Colors.white));
}
