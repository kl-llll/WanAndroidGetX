import 'dart:ui';

import 'package:flutter/material.dart';

class ResourceColors {
  static const Color defaultLightColor = Color(0xff5a50c6);
  static const Color defaultDarkColor = Color(0xff5046b8);

  static const Color backgroundLightColor = Color(0xfffdfdfd);
  static const Color backgroundDarkColor = Color(0xff303030);

  static const Color secondLightColor = Color(0xff8E8E93);
  static const Color secondDarkColor = Color(0xff6C6C70);

  static const Color splashFontColor = Color(0xffcfcfcf);


  static bool isLight = window.platformBrightness == Brightness.light;

  static Color adaptiveDefaultColor = isLight
      ? ResourceColors.defaultLightColor
      : ResourceColors.defaultDarkColor;

  static Color adaptiveBackgroundColor = isLight
      ? ResourceColors.backgroundLightColor
      : ResourceColors.backgroundDarkColor;

  static Color adaptiveSecondColor = isLight
      ? ResourceColors.secondLightColor
      : ResourceColors.secondDarkColor;

}
