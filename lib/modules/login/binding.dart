import 'package:get/get.dart';
import 'package:wan_android_getx/modules/login/controller.dart';

import '../../api/login_api.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginApi());
    Get.lazyPut(() => LoginController());
  }
}
