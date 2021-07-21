import 'package:get/get.dart';
import 'package:wan_android_getx/api/mine_api.dart';

import 'controller.dart';

class RankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RankController());
    Get.lazyPut(() => MineApi());
  }
}
