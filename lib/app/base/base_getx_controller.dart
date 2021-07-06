import 'package:get/get.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';
import 'package:wan_android_getx/routes/app_pages.dart';

typedef Success(dynamic value);
typedef Failure(dynamic value);
typedef Done();

class BaseGetXController extends GetxController {
  var loadState = LoadState.DONE.obs;

  var exception = HttpException("", 0).obs;

  var errorMessage = "加载失败".obs;

  void handleRequest(Future<dynamic> future, bool isLoading, Success success,
      {Failure? failure, Done? done}) {
    future.then((value) {
      if (isLoading) {
        loadState.value = LoadState.LOADING;
      }

      success(value);
    }).onError<HttpException>((error, stackTrace) {
      if (isLoading) {
        loadState.value = LoadState.FAILURE;
      }

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
      if (failure != null) {
        failure(error.msg);
      }
      errorMessage.value = error.msg;
    });
  }

  void initData(bool isShowLoading){

  }
  void refresh(){

  }
}
