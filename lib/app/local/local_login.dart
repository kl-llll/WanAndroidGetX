import 'package:get/get.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/const/hive_boxes.dart';

class LocalLogin extends BaseGetXController{

  var isLogin = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLogin.value=HiveBoxes.loginBox.get("isLogin")??false;
  }
}