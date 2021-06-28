import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> with AutomaticKeepAliveClientMixin {
  final controller = Get.find<QuestionController>();

  @override
    Widget build(BuildContext context) {
    super.build(context);
    return Container();
    }

  @override
  void dispose() {
    Get.delete<QuestionController>();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}