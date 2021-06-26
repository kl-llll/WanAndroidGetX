import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  ThemeData get lightTheme {
    final Color currentColor = ResourceColors.defaultLightColor;
    final Color backgroundColor = ResourceColors.backgroundLightColor;
    return ThemeData.light().copyWith(
      accentColor: currentColor,
      toggleableActiveColor: currentColor,
      indicatorColor: currentColor,
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        elevation: 0,
      ),
      buttonColor: currentColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: currentColor,
      ),
      colorScheme: ColorScheme(
        primary: currentColor,
        primaryVariant: currentColor,
        secondary: currentColor,
        secondaryVariant: currentColor,
        surface: Colors.white,
        background: backgroundColor,
        error: currentColor,
        onPrimary: currentColor,
        onSecondary: currentColor,
        onSurface: currentColor,
        onBackground: backgroundColor,
        onError: currentColor,
        brightness: Brightness.light,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: currentColor,
        selectionColor: currentColor.withOpacity(0.5),
        selectionHandleColor: currentColor,
      ),
    );
  }

  ThemeData get darkTheme {
    final Color currentColor = ResourceColors.defaultDarkColor;
    final Color backgroundColor = ResourceColors.backgroundDarkColor;
    return ThemeData.dark().copyWith(
      accentColor: currentColor,
      toggleableActiveColor: currentColor,
      indicatorColor: currentColor,
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        elevation: 0,
      ),
      buttonColor: currentColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: currentColor,
      ),
      colorScheme: ColorScheme(
        primary: currentColor,
        primaryVariant: currentColor,
        secondary: currentColor,
        secondaryVariant: currentColor,
        surface: Colors.white,
        background: backgroundColor,
        error: currentColor,
        onPrimary: currentColor,
        onSecondary: currentColor,
        onSurface: currentColor,
        onBackground: backgroundColor,
        onError: currentColor,
        brightness: Brightness.light,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: currentColor,
        selectionColor: currentColor.withOpacity(0.5),
        selectionHandleColor: currentColor,
      ),
    );
  }
}

class NoSplashFactory extends InteractiveInkFeatureFactory {
  const NoSplashFactory();

  @override
  InteractiveInkFeature create(
      {required MaterialInkController controller,
      required RenderBox referenceBox,
      required Offset position,
      required Color color,
      required TextDirection textDirection,
      bool containedInkWell = false,
      RectCallback? rectCallback,
      BorderRadius? borderRadius,
      ShapeBorder? customBorder,
      double? radius,
      VoidCallback? onRemoved}) {
    return NoSplash(
      controller: controller,
      referenceBox: referenceBox,
      onRemoved: onRemoved,
    );
  }
}

class NoSplash extends InteractiveInkFeature {
  NoSplash({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    VoidCallback? onRemoved,
  }) : super(
          controller: controller,
          referenceBox: referenceBox,
          onRemoved: onRemoved,
          color: Colors.transparent,
        ) {
    controller.addInkFeature(this);
  }

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {}
}
