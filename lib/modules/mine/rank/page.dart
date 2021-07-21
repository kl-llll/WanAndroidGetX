import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/widget/custom_app_bar.dart';
import 'package:wan_android_getx/widget/load_sir.dart';
import 'package:wan_android_getx/const/constants.dart';

import 'controller.dart';

class RankPage extends StatelessWidget {
  final controller = Get.find<RankController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: customAppBar(title: "排行榜", elevation: 1),
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
              child: CustomScrollView(slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            SvgPicture.asset(R.ASSETS_IMAGES_RANK1_SVG),
                            Text(controller.getRankList[0].username.toString()),
                            Text(controller.getRankList[0].level.toString()),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
