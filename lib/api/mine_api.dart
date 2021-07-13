import 'package:wan_android_getx/http/net/dio_new.dart';

class MineApi {
  final String bindImg =
      "https://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=2&mkt=zh-cn";

  Future getBingImage() async {
    Dio dio = Dio();
    return await dio.get(bindImg);
  }
}
