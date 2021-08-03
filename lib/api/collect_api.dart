import 'package:get/get.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

class CollectApi {
  final HttpClient _dio = Get.find<HttpClient>();

  String _collect(int id) => "/lg/collect/$id/json";
  String _unCollect(int id) => "/lg/uncollect_originId/$id/json";

  Future collect(int pageIndex) async => await _dio.post(_collect(pageIndex));
  Future unCollect(int pageIndex) async => await _dio.post(_unCollect(pageIndex));

}
