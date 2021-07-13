import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

class HotApi {
  final HttpClient _dio = Get.find<HttpClient>();

  final String _banner = "/banner/json";
  final String _topArticle = "/article/top/json";

  String _collect(int id) => "/lg/collect/$id/json";
  String _unCollect(int id) => "/lg/uncollect_originId/$id/json";

  String _homeArticle(int pageIndex) => "/article/list/$pageIndex/json";

  Future get getBanner async => await _dio.get(_banner);

  Future get getTopArticle async => await _dio.get(_topArticle);

  Future getHomeArticle(int pageIndex) async => await _dio.get(_homeArticle(pageIndex));

  Future collect(int pageIndex) async => await _dio.post(_collect(pageIndex));
  Future unCollect(int pageIndex) async => await _dio.post(_unCollect(pageIndex));
}
