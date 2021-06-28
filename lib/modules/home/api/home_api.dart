import 'package:get/get.dart';
import 'package:wan_android_getx/bean/home_article_model.dart';
import 'package:wan_android_getx/bean/user_info_model.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';
import 'package:wan_android_getx/http/net/http_response.dart';
import 'package:wan_android_getx/utils/extension/get_extension.dart';
import 'package:wan_android_getx/utils/log_util.dart';

class HomeApi {
  final HttpClient _dio = Get.find<HttpClient>();
  final String _logout = "/user/logout/json";
  final String _userInfo = "/lg/coin/userinfo/json";

  String _homeArticle(int index) => "/article/list/$index/json";

  Future<HomeArticleModel> getHomeArticleList(int index) async {
    HttpResponse appResponse = await _dio.get(_homeArticle(index));

    if (appResponse.ok) {
      return HomeArticleModel.fromJson(appResponse.data);
    } else {
      throw appResponse.error!.msg;
    }
  }

  Future logout() async {
    HttpResponse appResponse = await _dio.get(_logout);
    if (appResponse.ok) {
    } else {
      Log.e(appResponse.error!.msg);
    }
  }

  Future<UserInfoModel> getUserInfo() async {
    HttpResponse appResponse = await _dio.get(_userInfo);

    if (appResponse.ok) {
      return UserInfoModel.fromJson(appResponse.data);
    } else {
      throw appResponse.error!.msg;
    }
  }
}
