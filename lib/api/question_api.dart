import 'package:get/get.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

class QuestionApi {
  final HttpClient _dio = Get.find<HttpClient>();

  String _question(int pageId) => "/wenda/list/$pageId/json";

  Future getQuestionList(int pageId) async => await _dio.get(_question(pageId));
}
