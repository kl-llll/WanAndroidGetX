import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/utils/log_util.dart';

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
    return Container(
      color: Colors.deepPurpleAccent,
    );
  }

  @override
  void dispose() {
    Get.delete<SquareController>();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
