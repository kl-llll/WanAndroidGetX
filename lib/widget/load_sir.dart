import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/const/constants.dart';

enum LoadState { LOADING, SUCCESS, DONE, FAILURE, EMPTY }

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

  LoadingPage(this.isBanner);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Column(
        children: [
          Visibility(
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
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
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
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (c, i) {
                return Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.r),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2),
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
                          border: Border.all(color: Colors.black, width: 2),
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
            ),
          )
        ],
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

  LoadSir({
    required this.child,
    required this.onPressed,
    required this.controller,
    this.isBanner = false,
    this.isSkeleton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.loadState.value) {
        case LoadState.LOADING:
          return isSkeleton ? LoadingPage(isBanner) : LoadingState();
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
