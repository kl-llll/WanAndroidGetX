import 'package:get/get.dart';
import 'package:wan_android_getx/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  Future<void> onReady() async {
    await Future.delayed(Duration(seconds: 1));
    Get.offNamed(Routes.MAIN);
  }
}
