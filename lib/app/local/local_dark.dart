import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/const/hive_boxes.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/const/theme.dart';

class LocalDark extends BaseGetXController{

  var isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDark.value=HiveBoxes.darkBox.get("isDark")??false;
    if(isDark.value){
      Get.changeTheme(AppTheme().darkTheme);
    }else{
      Get.changeTheme(AppTheme().lightTheme);
    }
  }
}