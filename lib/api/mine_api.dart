import 'package:get/get.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

class MineApi {
  final HttpClient _dio = Get.find<HttpClient>();

  String bindImg(int index) =>
      "https://www.bing.com/HPImageArchive.aspx?format=xml&idx=$index&n=2&mkt=zh-cn";

  final String _userIntegral = "/lg/coin/userinfo/json";

  final String _logout = "/user/logout/json";

  Future get getIntegral async => await _dio.get(_userIntegral);

  Future getBingImage(int index) async {
    Dio dio = Dio();
    return await dio.get(bindImg(index));
  }

  Future get logout async => await _dio.get(_logout);
}
