import 'package:get/get.dart';

import 'api/home_api.dart';
import 'controller.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeApi());
    Get.lazyPut(() => HomeController());
  }
}
