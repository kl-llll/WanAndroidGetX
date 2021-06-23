import 'package:get/get.dart';
import 'package:wan_android_getx/http/apis.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

class DioConfigController extends GetxService {
  Future<HttpConfig> init() async {
    HttpConfig dioConfig = HttpConfig(baseUrl: Apis.BaseUrl);
    return dioConfig;
  }
}
