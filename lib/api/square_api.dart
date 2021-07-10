import 'package:get/get.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

class SquareApi {
  final HttpClient _dio = Get.find<HttpClient>();

  String _square(int pageIndex) => "/user_article/list/$pageIndex/json";

  Future getSquareList(int pageIndex) async => await _dio.get(_square(pageIndex));
}
