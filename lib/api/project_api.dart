import 'package:get/get.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

class ProjectApi {
  final HttpClient _dio = Get.find<HttpClient>();

  // 项目分类
  final String _projectTree = "/project/tree/json";

  // 项目列表
  String _getProjectList(int pageIndex) => "/project/list/$pageIndex/json";

  Future get getProjectTree => _dio.get(_projectTree);

  Future getProjectList(int pageIndex, int cId) =>
      _dio.get(_getProjectList(pageIndex), queryParameters: {"cid": cId});
}
