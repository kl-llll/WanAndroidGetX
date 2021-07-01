import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
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
        designSize: Size(360,690),
        builder: () => GetMaterialApp(
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
    );
  }
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}
