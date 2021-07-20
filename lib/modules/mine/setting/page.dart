import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: ListView(
        children: [

          Container(
            child: Text("主题",style: TextStyle(color: context.accentColor,fontSize: 14.sp),),
          ),
          Obx(
            () {
              return SwitchListTile(
                value: controller.localDark.isDark.value,
                title: Text("强制夜间模式"),
                secondary: Icon(
                  controller.localDark.isDark.value?CupertinoIcons.moon_circle:CupertinoIcons.sun_min_fill,
                  color: context.accentColor,
                ),
                onChanged: (v) => controller.changeSwitchValue(),
              );
            },
          ),
          Obx(
            () {
              return SwitchListTile(
                value: controller.localDark.isDark.value,
                title: Text("跟随系统"),
                secondary: Icon(
                  CupertinoIcons.phone,
                  color: context.accentColor,
                ),
                onChanged: (v) => controller.changeSwitchValue(),
              );
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.square_arrow_left,color: context.accentColor,),
            title: Text("退出登录"),
            trailing: Icon(CupertinoIcons.right_chevron),
            onTap: ()=>controller.logout(),
          )
        ],
      ),
    );
  }
}
