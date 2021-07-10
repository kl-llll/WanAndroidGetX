import 'package:get/get.dart';
import 'package:wan_android_getx/api/square_api.dart';

import 'controller.dart';

class SquareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SquareController());
    Get.lazyPut(() => SquareApi());
  }
}
