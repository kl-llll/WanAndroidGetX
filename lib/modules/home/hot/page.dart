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
import 'package:wan_android_getx/widget/article_item.dart';

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
        isBanner: true,
        child: SmartRefresher(
          controller: controller.refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () => controller.refresh(),
          onLoading: () => controller.loadMore(),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildSwiper(controller.getBannerList)),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return ArticleItem(
                      context: context,
                      data: controller.getHomeArticleList[index],
                      controller: controller);
                }, childCount: controller.getHomeArticleList.length),
              ),
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
                placeholder: (context, url) => LoadingState(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
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

  @override
  void dispose() {
    Get.delete<HotController>();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
