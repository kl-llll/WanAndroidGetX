import 'dart:ui';

import 'package:flutter/material.dart';

class ResourceColors {
  static const Color defaultLightColor = Color(0xff6484C3);
  static const Color defaultDarkColor = Color(0xff3A5F9B);

  static const Color backgroundLightColor = Color(0xfff7f7f7);
  static const Color backgroundDarkColor = Color(0xff121212);

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
