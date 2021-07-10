import 'dart:async';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/const/constants.dart';

class WebController extends GetxController {
  var url = "".obs;

  late InAppWebViewController _webViewController;

  get getInAppWebViewController => _webViewController;

  set setInAppWebViewController(InAppWebViewController c) =>
      _webViewController = c;

  var progress=0.0.obs;


  final GlobalKey webViewKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    var map = Get.arguments;
    url.value = map["url"];
  }



}
