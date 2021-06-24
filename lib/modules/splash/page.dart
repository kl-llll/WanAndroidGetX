import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class SplashPage extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        builder: (_) {
          return Column(
            children: [
              SizedBox(
                height: 120,
              ),
              Text('WanAndroidGetX')
            ],
          );
        },
      ),
    );
  }
}
