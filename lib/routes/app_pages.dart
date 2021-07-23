import 'package:get/get.dart';
import 'package:wan_android_getx/modules/home/hot/binding.dart';
import 'package:wan_android_getx/modules/home/question/binding.dart';
import 'package:wan_android_getx/modules/home/square/binding.dart';
import 'package:wan_android_getx/modules/login/binding.dart';
import 'package:wan_android_getx/modules/login/page.dart';
import 'package:wan_android_getx/modules/main_page.dart';
import 'package:wan_android_getx/modules/mine/binding.dart';
import 'package:wan_android_getx/modules/mine/collect/binding.dart';
import 'package:wan_android_getx/modules/mine/collect/page.dart';
import 'package:wan_android_getx/modules/mine/integral/binding.dart';
import 'package:wan_android_getx/modules/mine/integral/page.dart';
import 'package:wan_android_getx/modules/mine/rank/binding.dart';
import 'package:wan_android_getx/modules/mine/rank/page.dart';
import 'package:wan_android_getx/modules/mine/setting/binding.dart';
import 'package:wan_android_getx/modules/mine/setting/page.dart';
import 'package:wan_android_getx/modules/splash/page.dart';
import 'package:wan_android_getx/modules/web/binding.dart';
import 'package:wan_android_getx/modules/web/page.dart';

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
        LoginBinding(),
        MineBinding(),
      ],
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.WEB,
      page: () => WebPage(),
      binding: WebBinding(),
    ),
    GetPage(
      name: Routes.SETTING,
      page: () => SettingPage(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Routes.INTEGRAL,
      page: () => IntegralPage(),
      binding: IntegralBinding(),
    ),
    GetPage(
      name: Routes.RANK,
      page: () => RankPage(),
      binding: RankBinding(),
    ),
    GetPage(
      name: Routes.COLLECT,
      page: () => CollectPage(),
      binding: CollectBinding(),
    ),
  ];
}
