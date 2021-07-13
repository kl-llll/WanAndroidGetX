import 'package:get/get.dart';
import 'package:wan_android_getx/api/question_api.dart';

import 'controller.dart';

class QuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionController());
    Get.lazyPut(() => QuestionApi());
  }
}
