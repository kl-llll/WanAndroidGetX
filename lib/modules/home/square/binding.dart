import 'package:get/get.dart';

import 'controller.dart';

class SquareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SquareController());
  }
}
