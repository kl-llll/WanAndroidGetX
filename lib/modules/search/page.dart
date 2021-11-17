import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/const/hive_boxes.dart';
import 'package:wan_android_getx/modules/home/hot/controller.dart';
import 'package:wan_android_getx/widget/article_item.dart';
import 'package:wan_android_getx/widget/custom_neumorphic.dart';

import 'controller.dart';

class SearchPage extends StatelessWidget {
  final controller = Get.find<SearchController>();

  final hotController = Get.put(HotController());
  var searchBarController = Get.find<FloatingSearchBarController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loadState.value != LoadState.SUCCESS) {
        return historySearch();
      } else {
        return SmartRefresher(
          controller: controller.refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () => controller.refresh(),
          onLoading: () => controller.loadMore(),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ArticleItem(
                  context: context,
                  data: controller.getSearchList[index],
                  controller: hotController);
            },
            itemCount: controller.getSearchList.length,
          ),
        );
      }
    });
  }

  Widget historySearch() {
    Widget item(String title) {
      return Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  width: 4.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: AppColors.secondColor),
                ),
                Text(title),
              ],
            ),
            title == "历史搜索"
                ? Wrap(
                    children: controller.historyList.map((e) {
                      return GestureDetector(
                        onTap: () {
                          controller.searchKey.value = e;
                          controller.getSearch(true);
                          searchBarController.query = e;
                        },
                        child: Container(
                          margin: EdgeInsets.all(7),
                          child: CustomNeumorphic(
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(5)),
                              child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: AppColors.secondColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      e,
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.white,
                                          height: 1.1),
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (controller.historyList
                                            .contains(e)) {
                                          controller.historyList.remove(e);
                                          HiveBoxes.searchBox.put("history",
                                              controller.historyList);
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 0.7),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Icon(
                                          CupertinoIcons.clear,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      );
                    }).toList(),
                  )
                : Wrap(
                    children: controller.hotKey.map((element) {
                      return GestureDetector(
                        onTap: () {
                          controller.searchKey.value = element;
                          controller.getSearch(true);
                          searchBarController.query = element;
                        },
                        child: Container(
                          margin: EdgeInsets.all(7),
                          child: CustomNeumorphic(
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(5)),
                            child: Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: AppColors.secondColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                element,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.white,
                                    height: 1.1),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )
          ],
        ),
      );
    }

    return Column(
      children: [
        item("热门搜索"),
        item("历史搜索"),
      ],
    );
  }
}
