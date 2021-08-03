import 'package:get/get.dart';
import 'package:wan_android_getx/api/collect_api.dart';
import 'package:wan_android_getx/api/hot_api.dart';

import 'controller.dart';

class HotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HotController());
    Get.lazyPut(() => HotApi());
    Get.lazyPut(() => CollectApi());
  }
}
