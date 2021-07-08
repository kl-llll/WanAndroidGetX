import 'package:get/get.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';
import 'package:wan_android_getx/routes/app_pages.dart';

typedef Success(dynamic value);
typedef Failure(dynamic value);

class BaseGetXController extends GetxController {
  var loadState = LoadState.LOADING.obs;

  var exception = HttpException("", 0).obs;

  var errorMessage = "加载失败".obs;

  Future handleRequest(Future<dynamic> future, Success success,
      {Failure? failure}) async {
    loadState.value = LoadState.LOADING;

    await future.then((value) {
      success(value);
    }).onError<HttpException>((error, stackTrace) {
      againLogin(error);
      loadState.value = LoadState.FAILURE;
      if (failure != null) {
        failure(error.msg);
      }
      errorMessage.value = error.msg;
    });
  }

  void againLogin(HttpException error) {
    if (error.code == -1001) {
      Get.defaultDialog(
        title: "登录失效",
        content: Text("请重新登录"),
        confirm: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.teal),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: () => Get.offNamed(Routes.LOGIN),
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  void initData(bool isShowLoading) {}

  void refresh() {}
}
