import 'package:get/get.dart';
import 'package:wan_android_getx/api/mine_api.dart';
import 'package:wan_android_getx/app/local/local_dark.dart';
import 'package:wan_android_getx/app/local/local_login.dart';
import 'package:wan_android_getx/const/hive_boxes.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/const/theme.dart';

class SettingController extends GetxController {
  var _api = Get.find<MineApi>();
  var _isLogin = Get.find<LocalLogin>();

  var localDark = Get.find<LocalDark>();

  changeSwitchValue() {
    localDark.isDark.value = !localDark.isDark.value;
    HiveBoxes.darkBox.put("isDark", localDark.isDark.value);
    if (localDark.isDark.value) {
      Get.changeTheme(AppTheme().darkTheme);
    } else {
      Get.changeTheme(AppTheme().lightTheme);
    }
  }

  logout() async {
    _api.logout.then((value) {
      _isLogin.isLogin.value = false;
      HiveBoxes.loginBox.put("isLogin", false);
      Get.back();
      Get.showCustomSnackbar("退出登录成功!");
    });
  }
}
