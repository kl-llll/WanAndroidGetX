import 'package:get/get.dart';
import 'package:wan_android_getx/modules/splash/controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
