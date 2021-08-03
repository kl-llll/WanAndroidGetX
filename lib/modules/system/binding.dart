import 'package:get/get.dart';
import 'package:wan_android_getx/api/system_api.dart';

import 'controller.dart';

class SystemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SystemController());
    Get.lazyPut(() => SystemApi());
  }
}
