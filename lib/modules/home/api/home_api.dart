import 'package:wan_android_getx/utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

class HomeApi {
  final HttpClient _dio = Get.find<HttpClient>();
  final String _logout = "/user/logout/json";

  Future logout() async {
    HttpResponse appResponse = await _dio.get(_logout);

    if (appResponse.ok) {
      Log.d(appResponse.data);
    } else {
      Log.e(appResponse.error);
      // Get.snackbar("提示", appResponse.error);
    }
  }
}
