import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart' as OKToast;
import 'package:wan_android_getx/const/colors.dart';

void showToast(String msg) {
  OKToast.showToast(
    "$msg",
    duration: Duration(seconds: 2),
    position: OKToast.ToastPosition.center,
    backgroundColor: ResourceColors.adaptiveDefaultColor,
    radius: 10.0,
    textPadding: EdgeInsets.all(10),
  );
}


