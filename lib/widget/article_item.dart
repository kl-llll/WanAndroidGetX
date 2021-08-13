import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:like_button/like_button.dart';
import 'package:wan_android_getx/const/constants.dart';

class ArticleItem<T extends BaseGetXController> extends StatelessWidget {
  final BuildContext context;
  final HomeArticleDatas data;
  final T controller;

  const ArticleItem(
      {required this.context, required this.data, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(Routes.WEB, arguments: {"url": data.link}),
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
                  colors: data.fresh??false? [
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
        ),
        Positioned(
          top: 0,
          right: 20,
          child: transparentLikeButton(context, data, controller),
        ),
      ],
    );
  }

  Widget transparentLikeButton(
      BuildContext context, HomeArticleDatas data, T controller) {

    Future<bool> onLikeButtonTapped(bool isLiked) async {
      final bool success;
      if (isLiked) {
        success = await controller.unCollect(data.id!,data.originId);
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

  Container buildContent(HomeArticleDatas data) {
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
            height: 8.h,
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

  List<Widget> buildTagWidget(HomeArticleDatas data) {
    List<Widget> widgetList = [];

    topWidget(bool isFresh, {String text = ""}) => Neumorphic(
          style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
            depth: 1,
            lightSource: LightSource.topLeft,
            color: text.isNotEmpty
                ? AppColors.secondColor
                : AppColors.collocationColor,
          ),
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
          child: Container(
            child: topText(text.isNotEmpty
                ? text
                : isFresh
                    ? "新"
                    : "置顶"),
          ),
        );

    if (data.fresh??false) {
      widgetList.add(topWidget(true));
    }

    if (data.type == 1) {
      widgetList.add(topWidget(false));
    }

    var tagsList = data.tags??[];
    if (tagsList.isNotEmpty) {
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
}
