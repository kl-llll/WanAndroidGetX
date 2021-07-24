import 'package:get/get.dart';
import 'package:wan_android_getx/api/project_api.dart';

import 'controller.dart';

class ProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectController());
    Get.lazyPut(() => ProjectApi());
  }
}
