import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:like_button/like_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/bean/index.dart';
import 'package:wan_android_getx/const/constants.dart';

import 'controller.dart';

class HotPage extends StatefulWidget {
  @override
  _HotPageState createState() => _HotPageState();
}

class _HotPageState extends State<HotPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final controller = Get.put(HotController());

  @override
  void initState() {
    super.initState();
  }



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
          child: ListView(
            children: [
              _buildSwiper(controller.getBannerList),
              _buildArticleList(controller.getHomeArticleList)
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSwiper(List<BannerDataEntity> list) {
    return Container(
      height: 130.h,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          BannerDataEntity data = list[index];

          return InkWell(
            onTap: () => Get.toNamed(Routes.WEB, arguments: {"url": data.url}),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: data.imagePath!,
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
            ),
          );
        },
        itemCount: list.length,
        autoplay: true,
        pagination: SwiperPagination(
            alignment: Alignment.bottomCenter,
            //图片右下角的指示器大小
            builder: DotSwiperPaginationBuilder(
                size: 4, activeSize: 5, activeColor: context.accentColor)),
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }

  static Widget _buildArticleList(List<HomeArticleDatas> list) {

    return ListView.builder(
      itemBuilder: ((BuildContext context, int index) {
        HomeArticleDatas data = list[index];
        return Stack(
          children: [
            Neumorphic(
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
                        ? [
                            AppColors.collocationColor.withAlpha(1),
                            context.primaryColor
                          ]
                        : [
                            context.primaryColor,
                            context.primaryColor,
                          ],
                  ),
                ),
                child: buildContent(data),
              ),
            ),
            Positioned(
              top: 0,
              right: 20,
              child: transparentLikeButton(context, data,),
            ),
          ],
        );
      }),
      itemCount: list.length,
    );
  }

  static Stack transparentLikeButton(BuildContext context,
      HomeArticleDatas data, ) {

    Future<bool> onLikeButtonTapped(bool isLiked) async {
      final bool success;
      if (isLiked) {
        success = await controller.unCollect(data.id!);
      } else {
        success = await controller.collect(data.id!);
      }
      return success ? !isLiked : isLiked;
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Neumorphic(
          style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.circle(),
              depth: 2,
              lightSource: LightSource.topLeft,
              color: Colors.transparent),
          child: Container(
            width: 45.r,
            height: 45.r,
          ),
        ),
        LikeButton(
          onTap: onLikeButtonTapped,
          size: 30.r,
          likeCountPadding: EdgeInsets.zero,
          isLiked: data.collect,
          circleColor: CircleColor(
              start: AppColors.collocationColor.withAlpha(100),
              end: AppColors.collocationColor),
          bubblesColor: BubblesColor(
            dotPrimaryColor: AppColors.collocationColor.withAlpha(100),
            dotSecondaryColor: AppColors.collocationColor,
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              CupertinoIcons.heart_fill,
              color: isLiked ? AppColors.collocationColor : context.iconColor,
              size: 30.r,
            );
          },
        )
      ],
    );
  }

  static Container buildContent(HomeArticleDatas data) {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: buildTagWidget(data),
          ),
          SizedBox(
            height: 5.h,
          ),
          titleText(data.title.toString()),
          SizedBox(
            height: 5.h,
          ),
          Wrap(
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
    );
  }

  static List<Widget> buildTagWidget(HomeArticleDatas data) {
    List<Widget> widgetList = [];

    topWidget(bool isFresh, {String text = ""}) => Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
          decoration: BoxDecoration(
              color: text.isNotEmpty
                  ? AppColors.secondColor
                  : AppColors.collocationColor,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: topText(text.isNotEmpty
              ? text
              : isFresh
                  ? "新"
                  : "置顶"),
        );

    if (data.fresh!) {
      widgetList.add(topWidget(true));
    }

    if (data.type == 1) {
      widgetList.add(topWidget(false));
    }

    var tagsList = data.tags;
    if (tagsList!.isNotEmpty) {
      tagsList.forEach((element) {
        widgetList.add(topWidget(false, text: element.name!));
      });
    }

    if (widgetList.isEmpty) {
      widgetList.add(Container(
        padding: EdgeInsets.symmetric(vertical: 5.h),
      ));
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
