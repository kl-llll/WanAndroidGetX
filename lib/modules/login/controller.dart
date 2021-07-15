import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/api/login_api.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/utils/extension/get_extension.dart';

class LoginController extends BaseGetXController {
  var userNameController = TextEditingController();
  var userPwdController = TextEditingController();

  var _api = Get.find<LoginApi>();

  login() async {
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

    _api.login(userName, userPwd).then((value) {
      Get.showCustomSnackbar("登录成功!");
      changeLogin = true;
    });
  }

  logout() async {
    _api.logout.then((value) {
      Get.showCustomSnackbar("退出登录成功!");
      changeLogin = false;
    });
  }
}
