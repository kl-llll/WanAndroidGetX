import 'package:get/get.dart';
import 'package:wan_android_getx/api/collect_api.dart';
import 'package:wan_android_getx/api/search_api.dart';

import 'controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
    Get.lazyPut(() => SearchApi());
    Get.lazyPut(() => CollectApi());
  }
}
