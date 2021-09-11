import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/app/local/local_login.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/const/hive_boxes.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';
import 'package:wan_android_getx/routes/app_pages.dart';

typedef Success(dynamic value);
typedef Failure(dynamic value);

class BaseGetXController extends GetxController {
  var loadState = LoadState.LOADING.obs;

  var exception = HttpException("", 0).obs;

  var errorMessage = "加载失败".obs;

  initData() {}

  refresh() {}

  loadMore() {}

  collect(int id) async {}

  unCollect(int id, int? originId) async {}

  Future handlerStateRequest(Future<dynamic> future, Success success,
      {bool isLoading = false, Failure? failure}) async {
    if (isLoading) {
      loadState.value = LoadState.LOADING;
    }

    await future.then((value) {
      success(value);
    }).onError<HttpException>((error, stackTrace) {
      _checkLogin(error);
      if (isLoading) {
        loadState.value = LoadState.FAILURE;
      }
      if (failure != null) {
        failure(error.msg);
      }
      errorMessage.value = error.msg;
    });
  }

  Future handlerRequest(Future<dynamic> future, Success success,
      {Failure? failure}) async {
    await future.then((value) {
      success(value);
    }).onError<HttpException>((error, stackTrace) {
      _checkLogin(error);
      if (failure != null) {
        failure(error.msg);
      }
    });
  }

  _checkLogin(HttpException error) {
    if (error.code == -1001) {
      Get.showCustomSnackbar("请重新登录", title: "获取登录信息失败");
      var localLogin = Get.find<LocalLogin>();
      HiveBoxes.loginBox.put("isLogin", false);
      localLogin.isLogin.value = false;
    }
  }
}
