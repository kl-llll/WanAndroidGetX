import 'package:wan_android_getx/utils/log_util.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';
import 'package:wan_android_getx/utils/extension/get_extension.dart';

class HomeApi {
  final HttpClient _dio = Get.find<HttpClient>();
  final String _logout = "/user/logout/json";
  final String _userInfo = "/lg/coin/userinfo/json";

  Future logout() async {
    HttpResponse appResponse = await _dio.get(_logout);

    if (appResponse.ok) {
      Log.d(appResponse.data);
    } else {
      Log.e(appResponse.error!.msg);
      Get.showErrorSnackbar(appResponse.error!.msg, title: "错误提示");
    }
  }

  Future getUserInfo() async {
    HttpResponse appResponse = await _dio.get(_userInfo);

    if (appResponse.ok) {
      Log.d(appResponse.data);
    } else {
      Log.e(appResponse.error!.msg);
      Get.showErrorSnackbar(appResponse.error!.msg, title: "错误提示");
    }
  }
}
