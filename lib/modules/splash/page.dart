import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/const/resource.dart';
import 'package:wan_android_getx/utils/log_util.dart';

import 'controller.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  final SplashController controller = Get.put(SplashController());

  @override
  void initState() {
    super.initState();

    controller.animationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    controller.animation =
        Tween(begin: 0.0, end: 100.0).animate(controller.animationController)
          ..addListener(() {
            setState(() {
              // the state that has changed here is the animation object’s value
            });
          });
    controller.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: controller.animation.value,
        width: controller.animation.value,
        child: FlutterLogo(),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<SplashController>();
    super.dispose();
  }
}
