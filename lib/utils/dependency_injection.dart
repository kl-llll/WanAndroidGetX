import 'dart:io';

import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wan_android_getx/app/providers/dio_config_service.dart';
import 'package:wan_android_getx/app/providers/sp_service.dart';
import 'package:wan_android_getx/http/apis.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

/// 依赖注入
class DependencyInjection {
  static Future<void> init() async {
    // shared_preferences
    await Get.putAsync(() => AppSpController().init());

    // 网络请求
    await Get.putAsync(() => DioClientController().init());

    // 全局监听搜索框的Controller
    Get.put<FloatingSearchBarController>(FloatingSearchBarController());
  }
}
