import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
          onRefresh: () {},
          onLoading: () {},
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
        height: 120.w,
        margin: EdgeInsets.all(10.r),
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
                    height: 60.r,
                    width: 60.r,
                  );
                },
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            );
          },
          itemCount: controller.getBannerList.length,
          autoplay: true,
          pagination: SwiperPagination(
              alignment: Alignment.bottomCenter,
              //图片右下角的指示器大小
              builder: DotSwiperPaginationBuilder(size: 4, activeSize: 5,activeColor:context.accentColor)),
          viewportFraction: 0.8,
          scale: 0.9,
        ),
      ),
    );
  }

  SliverList get _buildArticleList {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          height: 20.h,
          color: Colors.white,
          child: Center(
            child: Text("${controller.getHomeArticleList[index].chapterName}"),
          ),
        );
      }, childCount: controller.getHomeArticleList.length),
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
