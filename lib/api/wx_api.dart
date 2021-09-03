import 'package:get/get.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

class WXApi {
  final HttpClient _dio = Get.find<HttpClient>();

  final String _wxTree = "/wxarticle/chapters/json  ";

  String _wxList(int id, int index) => "/wxarticle/list/$id/$index/json";

  Future get getWXTree async => await _dio.get(_wxTree);

  Future getWXList(int index, int id) async {
    return await _dio.get(_wxList(id, index));
  }
}
