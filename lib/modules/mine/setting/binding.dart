import 'package:get/get.dart';
import 'package:wan_android_getx/api/mine_api.dart';

import 'controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
    Get.lazyPut(() => MineApi());
  }
}
