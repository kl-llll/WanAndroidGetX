import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/api/login_api.dart';
import 'package:wan_android_getx/app/local/local_login.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/const/hive_boxes.dart';
import 'package:wan_android_getx/utils/extension/get_extension.dart';

class LoginController extends BaseGetXController {
  var userNameController = TextEditingController();
  var userPwdController = TextEditingController();

  var _api = Get.find<LoginApi>();

  var _isLogin = Get.find<LocalLogin>();

  login(Function startLoading, Function stopLoading) async {
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

    startLoading();
    handlerRequest(_api.login(userName, userPwd), (value) {
      stopLoading();
      _isLogin.isLogin.value = true;
      HiveBoxes.loginBox.put("isLogin", true);
      Get.back(closeOverlays: true);
      Get.showCustomSnackbar("登录成功!");
    }, failure: (e) {
      stopLoading();
      Get.showErrorSnackbar(e);
    });
  }
}
