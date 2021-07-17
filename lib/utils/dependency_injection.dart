import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:wan_android_getx/app/local/local_login.dart';
import 'package:wan_android_getx/app/providers/dio_config_service.dart';
import 'package:wan_android_getx/const/hive_boxes.dart';

/// 依赖注入
class DependencyInjection {
  static Future<void> init() async {

    await Hive.initFlutter();

    await HiveBoxes.openBoxes();

    // 网络请求
    await Get.putAsync(() => DioClientController().init());

    // 全局监听搜索框的Controller
    Get.put<FloatingSearchBarController>(FloatingSearchBarController());

    Get.put<LocalLogin>(LocalLogin());
  }
}
