import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wan_android_getx/bean/login_model.dart';
import 'package:wan_android_getx/modules/login/api/login_api.dart';
import 'package:wan_android_getx/utils/extension/get_extension.dart';

class LoginController extends GetxController {
  var userNameController = TextEditingController();
  var userPwdController = TextEditingController();

  var _api = Get.find<LoginApi>();
  SharedPreferences sp = Get.find<SharedPreferences>();

  void login() async {
    var userName = userNameController.value.text.trim();
    var userPwd = userPwdController.value.text.trim();

    if (userName.isEmpty) {
      GetExtension(Get).showCustomSnackbar("请输入账户名");
      return;
    }

    if (userPwd.isEmpty) {
      GetExtension(Get).showCustomSnackbar("请输入密码");

      return;
    }

    try {
      LoginModel model = await _api.login(userName, userPwd);
    } catch (e) {}
  }
}
