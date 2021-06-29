import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/utils/log_util.dart';

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
    return Container(color: Colors.amber,);
  }

  @override
  void dispose() {
    Get.delete<HotController>();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
