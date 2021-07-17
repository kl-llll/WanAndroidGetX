import 'package:get/get.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

class LoginApi {
  final HttpClient _dio = Get.find<HttpClient>();

  final String _login = "/user/login";

  final String _logout = "/user/logout/json";

  login(String username, String password) async =>
      await _dio.post(_login,
          queryParameters: {"username": "718326384@qq.com", "password": "wan12138"});


  Future get logout async => await _dio.get(_logout);
}
