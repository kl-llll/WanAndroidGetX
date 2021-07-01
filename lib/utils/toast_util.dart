
import 'package:oktoast/oktoast.dart' as OKToast;
import 'package:wan_android_getx/const/constants.dart';

void showToast(String msg) {
  OKToast.showToast(
    "$msg",
    duration: Duration(seconds: 2),
    position: OKToast.ToastPosition.center,
    backgroundColor:Get.context!.accentColor,
    radius: 10.0,
    textPadding: EdgeInsets.all(10),
  );
}
