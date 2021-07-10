import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/bean/home_article_entity.dart';
import 'package:wan_android_getx/const/constants.dart';

import 'controller.dart';

class SquarePage extends StatefulWidget {
  @override
  _SquarePageState createState() => _SquarePageState();
}

class _SquarePageState extends State<SquarePage>
    with AutomaticKeepAliveClientMixin {
  final controller = Get.find<SquareController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      return LoadSir(
        onPressed: () => controller.initData(),
        controller: controller,
        child: SmartRefresher(
          controller: controller.refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () => controller.refresh(),
          onLoading: () => controller.loadMore(),
          header: ClassicHeader(),
          footer: ClassicFooter(
            failedText: "123",
          ),
          child:ListView.builder(itemBuilder: (c,i){
            HomeArticleDatas data = controller.getSquareList[i];

            return InkWell(
              onTap: () => Get.toNamed(Routes.WEB,
                  arguments: {"url": data.link}),
              child: Neumorphic(
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                    depth: 4,
                    lightSource: LightSource.topLeft,
                    color: context.primaryColor),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: data.fresh!
                      ? [Color(0xffDB79AC).withAlpha(1), context.primaryColor]
                      : [context.primaryColor, context.primaryColor],
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: _buildTagWidget(data),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        titleText(data.title.toString()),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            secondText(data.author!.isEmpty
                                ? "分享人:${data.shareUser}"
                                : "作者:${data.author}"),
                            SizedBox(
                              width: 5.w,
                            ),
                            secondText(
                                "分类:${data.chapterName}/${data.superChapterName}"),
                            SizedBox(
                              width: 5.w,
                            ),
                            secondText("${data.niceDate}"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );

          },
          itemCount: controller.getSquareList.length,)
        ),
      );
    });
  }

  List<Widget> _buildTagWidget(HomeArticleDatas data) {
    List<Widget> widgetList = [];

    topNewWidget(bool isFresh) => Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
      decoration: BoxDecoration(
          color: Color(0xffDB79AC),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: topText(isFresh ? "新" : "置顶"),
    );

    tagWidget(String text) => Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
      decoration: BoxDecoration(
          color: Color(0xff7FAFE2),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: topText(text),
    );

    if (data.fresh!) {
      widgetList.add(topNewWidget(true));
    }

    if (data.type == 1) {
      widgetList.add(topNewWidget(false));
    }

    var tagsList = data.tags;
    if (tagsList!.isNotEmpty) {
      tagsList.forEach((element) {
        widgetList.add(tagWidget(element.name!));
      });
    }

    return widgetList;
  }

  @override
  void dispose() {
    Get.delete<SquareController>();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
