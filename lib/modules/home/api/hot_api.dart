import 'package:wan_android_getx/bean/banner_model.dart';
import 'package:wan_android_getx/bean/home_article_model.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

class HotApi {
  final HttpClient _dio = Get.find<HttpClient>();

  final String _banner = "/banner/json";
  final String _topArticle = "/article/top/json";

  String _homeArticle(int index) => "/article/list/$index/json";

  Future getHomeArticle(int index) async {
    HttpResponse appResponse = await _dio.get(_homeArticle(index));

    if (appResponse.ok) {
      return appResponse.data;
    } else {
      throw appResponse.error!.msg;
    }
  }

  Future get getTopArticle async {
    HttpResponse appResponse = await _dio.get(_topArticle);

    if (appResponse.ok) {
      return appResponse.data;
    } else {
      throw appResponse.error!.msg;
    }
  }

  Future get getBanner async {
    HttpResponse appResponse = await _dio.get(_banner);

    if (appResponse.ok) {
      return appResponse.data;
    } else {
      throw appResponse.error!.msg;
    }
  }
}
