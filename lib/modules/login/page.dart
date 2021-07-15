import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wan_android_getx/utils/log_util.dart';

import 'controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("WanAndroid"),
            Column(
              children: [
                TextField(
                  controller: controller.userNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "账号"),
                ),
                SizedBox(height: 20.h),
                TextField(
                  controller: controller.userPwdController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "密码"),
                ),
              ],
            ),
            TextButton(onPressed: () => controller.login(), child: Text("登录")),
            TextButton(onPressed: () => controller.logout(), child: Text("退出")),
          ],
        ),
      ),
    );
  }
}
