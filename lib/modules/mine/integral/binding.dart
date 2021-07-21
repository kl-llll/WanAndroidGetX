import 'package:get/get.dart';
import 'package:wan_android_getx/api/mine_api.dart';

import 'controller.dart';

class IntegralBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IntegralController());
    Get.lazyPut(() => MineApi());
  }
}
