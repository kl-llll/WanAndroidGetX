import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/widget/custom_app_bar.dart';
import 'package:wan_android_getx/widget/load_sir.dart';
import 'package:wan_android_getx/const/constants.dart';

import 'controller.dart';

class IntegralPage extends StatelessWidget {
  final controller = Get.find<IntegralController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "积分列表", elevation: 1),
      body: LoadSir(
        onPressed: () => controller.initData(),
        controller: controller,
        isSkeleton: false,
        child: SmartRefresher(
          controller: controller.refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () => controller.refresh(),
          onLoading: () => controller.loadMore(),
          child: Obx(() {
            return ListView.builder(
              itemBuilder: (c, i) {
                return Container(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        CupertinoIcons.sparkles,
                        color: AppColors.secondColor,
                      ),
                      Text("${controller.getIntegralList[i].desc}"),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Color(0xffe5e5e5),
                      ),
                    ),
                  ),
                );
              },
              itemCount: controller.getIntegralList.length,
            );
          }),
        ),
      ),
    );
  }
}
