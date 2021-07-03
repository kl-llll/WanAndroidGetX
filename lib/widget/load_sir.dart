
import 'package:flutter/widgets.dart';
import 'package:wan_android_getx/const/constants.dart';

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
        child: Image.asset(
          R.ASSETS_IMAGES_LOGO_PNG,
          width: 50.r,
          height: 50.r,
        ),
      ),
    );
  }
}
