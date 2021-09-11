import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:wan_android_getx/widget/app_bar_icon.dart';
import 'package:wan_android_getx/const/constants.dart';

import 'controller.dart';

class SettingPage extends StatelessWidget {
  final controller = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.canvasColor,
        leading: Container(
          padding: EdgeInsets.all(12.r),
          child: AppBarIcon(
            assetName: R.ASSETS_IMAGES_BACK_SVG,
            onTap: () => Get.back(),
          ),
        ),
        centerTitle: true,
        title: Text(
          "设置",
          style: TextStyle(color: context.accentColor, fontSize: 19.sp),
        ),
      ),
      body: Column(
        children: [
          Obx(
            () {
              return SwitchListTile(
                value: controller.localDark.isDark.value,
                title: Text("夜间模式"),
                secondary: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                  child: Icon(
                    controller.localDark.isDark.value
                        ? CupertinoIcons.moon_fill
                        : CupertinoIcons.sun_min_fill,
                    key: ValueKey<bool>(controller.localDark.isDark.value),
                    color: context.accentColor,
                  ),
                ),
                onChanged: (v) => controller.changeSwitchValue(),
              );
            },
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.square_arrow_left,
              color: context.accentColor,
            ),
            title: Text("退出登录"),
            onTap: () => controller.logout(),
          )
        ],
      ),
    );
  }
}
