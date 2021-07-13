import 'package:get/get.dart';
import 'package:wan_android_getx/api/mine_api.dart';

import 'controller.dart';

class MineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MineController());
    Get.lazyPut(() => MineApi());
  }
}
