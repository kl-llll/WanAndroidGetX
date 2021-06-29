import 'package:get/get.dart';
import 'package:wan_android_getx/modules/home/hot/binding.dart';
import 'package:wan_android_getx/modules/home/question/binding.dart';
import 'package:wan_android_getx/modules/home/square/binding.dart';
import 'package:wan_android_getx/modules/login/binding.dart';
import 'package:wan_android_getx/modules/main_page.dart';
import 'package:wan_android_getx/modules/splash/page.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => MainPage(),
      bindings: [
        HotBinding(),
        QuestionBinding(),
        SquareBinding(),
        LoginBinding()
      ],
    ),

  ];
}
