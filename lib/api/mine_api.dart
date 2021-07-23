import 'package:get/get.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

class MineApi {
  final HttpClient _dio = Get.find<HttpClient>();

  // 用户积分 排名 等级
  final String _userIntegral = "/lg/coin/userinfo/json";

  // 退出登录
  final String _logout = "/user/logout/json";

  // 获取必应的每日一图
  String _bindImg(int index) =>
      "https://www.bing.com/HPImageArchive.aspx?format=xml&idx=$index&n=2&mkt=zh-cn";

  // 积分获取列表
  String _userIntegralList(int index) => "/lg/coin/list/$index/json";

  // 排行榜列表
  String _userRankList(int index) => "/coin/rank/$index/json";

  // 收藏文章列表
  String _collectList(int index) => "/lg/collect/list/$index/json";

  Future get getIntegral async => await _dio.get(_userIntegral);

  Future get logout async => await _dio.get(_logout);

  Future getBingImage(int index) async {
    Dio dio = Dio();
    return await dio.get(_bindImg(index));
  }

  Future getIntegralList(int index) async {
    return await _dio.get(_userIntegralList(index));
  }

  Future getRankList(int index) async {
    return await _dio.get(_userRankList(index));
  }

  Future getCollectList(int index) async {
    return await _dio.get(_collectList(index));
  }
}
