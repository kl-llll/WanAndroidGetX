import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/routes/app_pages.dart';

class SplashController extends GetxController {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onReady() {
    super.onReady();
    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        Get.offNamed(Routes.MAIN);
      }
    });
  }
}
