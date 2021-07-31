import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/const/constants.dart';

enum LoadState { LOADING, SUCCESS, DONE, FAILURE, EMPTY }
enum LoadType { ARTICLE, PROJECT }

class LoadingState extends StatefulWidget {
  const LoadingState({
    Key? key,
  }) : super(key: key);

  @override
  _LoadingStateState createState() => _LoadingStateState();
}

class _LoadingStateState extends State<LoadingState>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller = (AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200)))
      ..addListener(() => setState(() {}))
      ..repeat();
    _animation1 = Tween(begin: 0.0, end: 180.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn)));
    _animation2 = Tween(begin: 180.0, end: 0.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform(
        transform: Matrix4.identity()
          ..rotateY((0 - _animation1.value) * 0.0174533)
          ..rotateY((_animation2.value - 0) * 0.0174533),
        alignment: FractionalOffset.center,
        child: SvgPicture.asset(
          R.ASSETS_IMAGES_LOADING_SVG,
          width: 50.r,
          height: 50.r,
        ),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  final bool isBanner;
  final LoadType loadType;

  LoadingPage({required this.loadType, required this.isBanner});

  Visibility _buildSkeletonBanner() {
    return Visibility(
      visible: isBanner,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 110.h,
              width: 25.w,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            Container(
              height: 130.h,
              width: 290.w,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
            ),
            Container(
              height: 110.h,
              width: 25.w,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget get _article {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (c, i) {
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: _buildTag(i),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 20.h,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: 50.w,
                    height: 20.h,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 200.w,
                    height: 15.h,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 20,
              child: Container(
                width: 45.r,
                height: 45.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Icon(
                  CupertinoIcons.heart_fill,
                  color: Colors.black,
                  size: 30.r,
                ),
              ),
            ),
          ],
        );
      },
      itemCount: 4,
    );
  }

  Widget get _project {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                  color: Colors.black,
                ),
                height: 150.h,
                width: double.maxFinite,
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: 20.h,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      width: 100.w,
                      height: 20.h,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 12.h,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 12.h,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100.w,
                            height: 12.h,
                            color: Colors.black,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            height: 20.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black),
                          ),
                        ]),
                  ],
                ),
              )
            ],
          ),
        );
      },
      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 2.0,
    );
  }

  Widget get _listWidget {
    switch (loadType) {
      case LoadType.PROJECT:
        return _project;
      case LoadType.ARTICLE:
        return _article;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Column(
        children: [_buildSkeletonBanner(), Expanded(child: _listWidget)],
      ),
      baseColor: context.iconColor!,
      highlightColor: Colors.grey[600]!,
    );
  }

  List<Widget> _buildTag(int i) {
    List<Widget> list = [];

    Container container() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        height: 20.h,
        width: 30.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.black),
      );
    }

    for (var y = 0; y < i + 1; y++) {
      list.add(container());
    }

    return list;
  }
}

class EmptyPage extends StatelessWidget {
  final VoidCallback onPressed;

  EmptyPage({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              R.ASSETS_IMAGES_EMPTY_SVG,
              height: 80.r,
              width: 80.r,
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text("暂无数据哦!"),
            Padding(padding: EdgeInsets.only(top: 10)),
            OutlinedButton(
              child: Text("点击刷新",
                  style: TextStyle(color: context.accentColor, fontSize: 15)),
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  final VoidCallback onPressed;
  final String errorMsg;

  ErrorPage({required this.onPressed, this.errorMsg = "出错啦!"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              R.ASSETS_IMAGES_ERROR_SVG,
              height: 80.r,
              width: 80.r,
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(errorMsg),
            Padding(padding: EdgeInsets.only(top: 10)),
            OutlinedButton(
              child: Text("点击刷新",
                  style: TextStyle(color: context.accentColor, fontSize: 15)),
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}

class LoadSir<T extends BaseGetXController> extends StatelessWidget {
  final T controller;
  final Widget child;
  final VoidCallback onPressed;
  final bool isBanner;
  final bool isSkeleton;
  final LoadType loadType;

  LoadSir({
    required this.child,
    required this.onPressed,
    required this.controller,
    this.loadType = LoadType.ARTICLE,
    this.isBanner = false,
    this.isSkeleton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.loadState.value) {
        case LoadState.LOADING:
          return isSkeleton
              ? LoadingPage(
                  loadType: loadType,
                  isBanner: isBanner,
                )
              : LoadingState();
        case LoadState.EMPTY:
          return EmptyPage(onPressed: onPressed);
        case LoadState.FAILURE:
          return ErrorPage(
              onPressed: onPressed, errorMsg: controller.errorMessage.value);
        default:
          return child;
      }
    });
  }
}
