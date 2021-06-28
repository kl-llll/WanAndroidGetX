import 'package:get/get.dart';
import 'package:wan_android_getx/modules/home/api/home_api.dart';

class HomeController extends GetxController {
  var _api = Get.find<HomeApi>();

  final List<String> titleList = ["热门", "广场", "问答"];

}
