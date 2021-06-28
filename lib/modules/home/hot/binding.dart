import 'package:get/get.dart';

import 'controller.dart';

class HotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HotController());
  }
}
