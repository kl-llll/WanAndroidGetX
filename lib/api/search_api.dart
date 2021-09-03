import 'package:get/get.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

class SearchApi {
  final HttpClient _dio = Get.find<HttpClient>();

  String get _hotkey => "hotkey/json";

  String _searchKey(int pageIndex) => "article/query/$pageIndex/json?";

  Future get getHotKey async => await _dio.get(_hotkey);

  Future searchKey(int pageIndex, String key) async =>
      await _dio.postFormData(_searchKey(pageIndex), data: {"key": key});
}
