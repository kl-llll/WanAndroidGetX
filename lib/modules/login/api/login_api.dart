import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';
import 'package:wan_android_getx/utils/log_util.dart';

class LoginApi {
  final HttpClient _dio = Get.find<HttpClient>();
  final String _login = "/user/login";

  Future login(String username, String password) async {
    HttpResponse appResponse = await _dio.post(_login,
        queryParameters: {"username": username, "password": password});

    if (appResponse.ok) {
      Log.d(appResponse.data);
      return appResponse.data;
    } else {
      Log.e(appResponse.error!.msg);
      Get.snackbar("提示", appResponse.error!.msg,colorText: Colors.red);
    }
  }
}
