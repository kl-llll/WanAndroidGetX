import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/routes/app_pages.dart';

import 'controller.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        TextButton(
          onPressed: () => Get.toNamed(Routes.LOGIN),
          child: Text("登录"),
        ),
        TextButton(
          onPressed: () => controller.logout(),
          child: Text("退出登录"),
        ),
        TextButton(
          onPressed: () => controller.getUserInfo(),
          child: Text("获取积分"),
        ),
      ],
    ));
  }
}
