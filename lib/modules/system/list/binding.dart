import 'package:get/get.dart';
import 'package:wan_android_getx/api/collect_api.dart';
import 'package:wan_android_getx/api/system_api.dart';

import 'controller.dart';

class ListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListController());
    Get.lazyPut(() => SystemApi());
    Get.lazyPut(() => CollectApi());
  }
}
