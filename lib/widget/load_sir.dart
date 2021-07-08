import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/const/constants.dart';

enum LoadState { LOADING, SUCCESS, FAILURE, EMPTY }

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

class EmptyPage extends StatelessWidget {
  VoidCallback onPressed;

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
  VoidCallback onPressed;
  String errorMsg;

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

  LoadSir(
      {required this.child, required this.onPressed, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.loadState.value) {
        case LoadState.LOADING:
          return LoadingState();
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

