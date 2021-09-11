import 'package:wan_android_getx/const/constants.dart';

extension GetExtension on GetInterface {
  void showCustomSnackbar(String msg, {String title = "提示"}) {
    Get.snackbar(title, msg,
        colorText: context!.accentColor,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 45.h));
  }

  void showErrorSnackbar(String msg, {String title = "错误提示"}) {
    Get.snackbar(title, msg,
        colorText: Colors.red, snackPosition: SnackPosition.BOTTOM);
  }
}
