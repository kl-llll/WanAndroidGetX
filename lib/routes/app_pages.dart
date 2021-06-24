import 'package:get/get.dart';
import 'package:wan_android_getx/modules/home/binding.dart';
import 'package:wan_android_getx/modules/home/page.dart';
import 'package:wan_android_getx/modules/login/binding.dart';
import 'package:wan_android_getx/modules/login/page.dart';
import 'package:wan_android_getx/modules/splash/binding.dart';
import 'package:wan_android_getx/modules/splash/page.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: Routes.SIGN_UP,
    //   page: () => SignUpPage(),
    //   binding: SiginUpBinding(),
    // ),
  ];
}
