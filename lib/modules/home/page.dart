import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => controller.logout(),
        child: Text("退出登录"),
      ),
    );
  }
}
