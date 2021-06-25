import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalLogin{


  static final String loginKey="login_key";


  static saveLoginInfo(){
    SharedPreferences sp = Get.find<SharedPreferences>();
    // sp.setString(loginKey, value)
  }


}