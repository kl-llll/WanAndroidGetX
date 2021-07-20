import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/routes/app_pages.dart';
import 'package:wan_android_getx/utils/dependency_injection.dart';

import 'const/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependencyInjection.init();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => RefreshConfiguration(
          headerBuilder: () => WaterDropHeader(),
          // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
          footerBuilder: () => ClassicFooter(),
          // 配置默认底部指示器
          headerTriggerDistance: 80.0,
          // 头部触发刷新的越界距离
          springDescription:
              SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.SPLASH,
            getPages: AppPages.pages,

            theme: AppTheme().lightTheme,
            darkTheme: AppTheme().darkTheme,
            defaultTransition: Transition.fade,
            builder: (c, w) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                // Global GestureDetector that will dismiss the keyboard
                body: GestureDetector(
                  onTap: () {
                    hideKeyboard(c);
                  },
                  child: w,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}
