import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/const/resource.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'controller.dart';

class SplashPage extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          R.ASSETS_IMAGES_LOGO_PNG,
          width: 100.w,
        ),
      ),
    );
  }
}
