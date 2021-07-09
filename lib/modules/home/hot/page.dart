import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/bean/index.dart';
import 'package:wan_android_getx/const/constants.dart';

import 'controller.dart';

class HotPage extends StatefulWidget {
  @override
  _HotPageState createState() => _HotPageState();
}

class _HotPageState extends State<HotPage> with AutomaticKeepAliveClientMixin {
  final controller = Get.put(HotController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      return LoadSir(
        onPressed: () {},
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
          child: CustomScrollView(
            slivers: [_buildSwiper, _buildArticleList],
          ),
        ),
      );
    });
  }

  SliverToBoxAdapter get _buildSwiper {
    return SliverToBoxAdapter(
      child: Container(
        height: 130.h,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: controller.getBannerList[index].imagePath!,
                placeholder: (context, url) {
                  return SvgPicture.asset(
                    R.ASSETS_IMAGES_EMPTY_SVG,
                    fit: BoxFit.cover,
                    height: 30.r,
                    width: 30.r,
                  );
                },
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.fill,
              ),
            );
          },
          itemCount: controller.getBannerList.length,
          autoplay: true,
          pagination: SwiperPagination(
              alignment: Alignment.bottomCenter,
              //图片右下角的指示器大小
              builder: DotSwiperPaginationBuilder(
                  size: 4, activeSize: 5, activeColor: context.accentColor)),
          viewportFraction: 0.8,
          scale: 0.9,
        ),
      ),
    );
  }

  SliverList get _buildArticleList {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        HomeArticleDatas data = controller.getHomeArticleList[index];
        return Neumorphic(
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
              depth: 5,
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
                      secondText("分类:${data.chapterName}/${data.superChapterName}"),
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
        );
      }, childCount: controller.getHomeArticleList.length),
    );
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
    Get.delete<HotController>();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
