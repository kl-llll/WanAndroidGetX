import 'package:get/get.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

class SystemApi {
  final HttpClient _dio = Get.find<HttpClient>();

  final String _systemTree = "/tree/json";

  String _systemList(int index) => "/article/list/$index/json";

  Future get getSystemTree async => await _dio.get(_systemTree);

  Future getSystemList(int index, int cid) async {
    return await _dio.get(_systemList(index), queryParameters: {"cid": cid});
  }
}
