import 'package:get/get.dart';
import 'package:wan_android_getx/modules/home/api/home_api.dart';
import 'package:wan_android_getx/routes/app_pages.dart';

class HomeController extends GetxController {
  var _api = Get.find<HomeApi>();

  void logout() async {

    _api.logout().then((value) => Get.offNamed(Routes.SPLASH));
  }
}
