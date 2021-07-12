import 'package:get/get.dart';
import 'package:wan_android_getx/bean/login_model.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

class LoginApi {
  final HttpClient _dio = Get.find<HttpClient>();
  final String _login = "/user/login";

  Future<LoginModel> login(String username, String password) async {
    HttpResponse? appResponse = await _dio.post(_login,
        queryParameters:{"username": username, "password": password});

    if (appResponse!.ok) {
      return LoginModel.fromJson(appResponse.data);
    } else {
      throw appResponse.error!.msg;
    }
  }
}
