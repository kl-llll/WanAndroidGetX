import 'dart:io';

import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wan_android_getx/app/providers/sp_service.dart';
import 'package:wan_android_getx/http/apis.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';

/// 依赖注入
class DependencyInjection {
  static Future<void> init() async {
    // shared_preferences
    await Get.putAsync(() => AppSpController().init());

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String cookiesPath = appDocDir.path + ".cookies/";
    HttpConfig dioConfig = HttpConfig(
        baseUrl: Apis.BaseUrl,
        proxy: "192.168.1.150:8866",
        cookiesPath: cookiesPath);
    HttpClient client = HttpClient(dioConfig: dioConfig);
    // 网络请求
    Get.put(client);

    // 全局监听搜索框的Controller
    FloatingSearchBarController searchBarController =
        FloatingSearchBarController();
    Get.put<FloatingSearchBarController>(searchBarController);
  }
}
