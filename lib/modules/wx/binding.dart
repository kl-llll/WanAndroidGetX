import 'package:get/get.dart';
import 'package:wan_android_getx/api/collect_api.dart';
import 'package:wan_android_getx/api/wx_api.dart';

import 'controller.dart';

class WXBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WXController());
    Get.lazyPut(() => WXApi());
    Get.lazyPut(() => CollectApi());

  }
}
