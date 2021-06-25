import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  ThemeGroup _currentThemeGroup = defaultThemeGroup;

  ThemeGroup get currentThemeGroup => _currentThemeGroup;

  ThemeData get lightTheme {
    final Color currentColor = currentThemeGroup.lightThemeColor;
    final Color primaryColor = currentThemeGroup.lightPrimaryColor;
    final Color backgroundColor = currentThemeGroup.lightBackgroundColor;
    final Color iconColor = currentThemeGroup.lightIconUnselectedColor;
    final Color dividerColor = currentThemeGroup.lightDividerColor;
    final Color primaryTextColor = currentThemeGroup.lightPrimaryTextColor;
    final Color secondaryTextColor = currentThemeGroup.lightSecondaryTextColor;

    return ThemeData.light().copyWith(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      primaryColorBrightness: Brightness.light,
      primaryColorLight: primaryColor,
      primaryColorDark: backgroundColor,
      accentColor: currentColor,
      accentColorBrightness: Brightness.light,
      canvasColor: backgroundColor,
      dividerColor: dividerColor,
      scaffoldBackgroundColor: backgroundColor,
      bottomAppBarColor: primaryColor,
      cardColor: primaryColor,
      highlightColor: Colors.transparent,
      splashFactory: const NoSplashFactory(),
      toggleableActiveColor: currentColor,
      indicatorColor: currentColor,
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        elevation: 0,
        color: primaryColor,
      ),
      buttonColor: currentColor,
      iconTheme: IconThemeData(color: iconColor),
      primaryIconTheme: IconThemeData(color: secondaryTextColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: primaryColor,
        backgroundColor: currentColor,
      ),
      tabBarTheme: TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: primaryTextColor,
        unselectedLabelColor: primaryTextColor,
      ),
      colorScheme: ColorScheme(
        primary: currentColor,
        primaryVariant: currentColor,
        secondary: currentColor,
        secondaryVariant: currentColor,
        surface: Colors.white,
        background: backgroundColor,
        error: ResourceColors.defaultLightColor,
        onPrimary: currentColor,
        onSecondary: currentColor,
        onSurface: ResourceColors.defaultLightColor,
        onBackground: backgroundColor,
        onError: ResourceColors.defaultLightColor,
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(color: secondaryTextColor),
        bodyText2: TextStyle(color: primaryTextColor),
        button: TextStyle(color: primaryTextColor),
        caption: TextStyle(color: secondaryTextColor),
        subtitle1: TextStyle(color: secondaryTextColor),
        headline1: TextStyle(color: secondaryTextColor),
        headline2: TextStyle(color: secondaryTextColor),
        headline3: TextStyle(color: secondaryTextColor),
        headline4: TextStyle(color: secondaryTextColor),
        headline5: TextStyle(color: primaryTextColor),
        headline6: TextStyle(color: primaryTextColor),
        overline: TextStyle(color: primaryTextColor),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: currentColor,
        selectionColor: currentColor.withOpacity(0.5),
        selectionHandleColor: currentColor,
      ),
    );
  }

  ThemeData get darkTheme {
    final Color currentColor = currentThemeGroup.darkThemeColor;
    final Color primaryColor = currentThemeGroup.darkPrimaryColor;
    final Color backgroundColor = currentThemeGroup.darkBackgroundColor;
    final Color iconColor = currentThemeGroup.darkIconUnselectedColor;
    final Color dividerColor = currentThemeGroup.darkDividerColor;
    final Color primaryTextColor = currentThemeGroup.darkPrimaryTextColor;
    final Color secondaryTextColor = currentThemeGroup.darkSecondaryTextColor;
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      primaryColorBrightness: Brightness.dark,
      primaryColorLight: backgroundColor,
      primaryColorDark: primaryColor,
      accentColor: currentColor,
      accentColorBrightness: Brightness.dark,
      canvasColor: backgroundColor,
      dividerColor: dividerColor,
      scaffoldBackgroundColor: backgroundColor,
      bottomAppBarColor: primaryColor,
      cardColor: primaryColor,
      highlightColor: Colors.transparent,
      splashFactory: const NoSplashFactory(),
      toggleableActiveColor: currentColor,
      indicatorColor: currentColor,
      appBarTheme: const AppBarTheme(
        brightness: Brightness.dark,
        elevation: 0,
        color: Colors.black,
      ),
      buttonColor: currentColor,
      iconTheme: IconThemeData(color: iconColor),
      primaryIconTheme: IconThemeData(color: secondaryTextColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.black,
        backgroundColor: currentColor,
      ),
      tabBarTheme: TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: primaryTextColor,
        unselectedLabelColor: primaryTextColor,
      ),
      colorScheme: ColorScheme(
        primary: currentColor,
        primaryVariant: currentColor,
        secondary: currentColor,
        secondaryVariant: currentColor,
        surface: primaryColor,
        background: backgroundColor,
        error: ResourceColors.defaultLightColor,
        onPrimary: currentColor,
        onSecondary: currentColor,
        onSurface: primaryColor,
        onBackground: backgroundColor,
        onError: ResourceColors.defaultLightColor,
        brightness: Brightness.dark,
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(color: secondaryTextColor),
        bodyText2: TextStyle(color: primaryTextColor),
        button: TextStyle(color: primaryTextColor),
        caption: TextStyle(color: secondaryTextColor),
        subtitle1: TextStyle(color: secondaryTextColor),
        headline1: TextStyle(color: secondaryTextColor),
        headline2: TextStyle(color: secondaryTextColor),
        headline3: TextStyle(color: secondaryTextColor),
        headline4: TextStyle(color: secondaryTextColor),
        headline5: TextStyle(color: primaryTextColor),
        headline6: TextStyle(color: primaryTextColor),
        overline: TextStyle(color: primaryTextColor),
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

const ThemeGroup defaultThemeGroup = ThemeGroup();


class ThemeGroup {
  const ThemeGroup({
    this.lightThemeColor = ResourceColors.defaultLightColor,
    this.lightPrimaryColor = Colors.white,
    this.lightBackgroundColor = const Color(0xfff7f7f7),
    this.lightIconUnselectedColor = const Color(0xffc4c4c4),
    this.lightDividerColor = const Color(0xffeaeaea),
    this.lightPrimaryTextColor = const Color(0xff212121),
    this.lightSecondaryTextColor = const Color(0xff757575),
    this.lightButtonTextColor = Colors.white,
    this.darkThemeColor = ResourceColors.defaultDarkColor,
    this.darkPrimaryColor = const Color(0xff212121),
    this.darkBackgroundColor = const Color(0xff151515),
    this.darkIconUnselectedColor = const Color(0xff616161),
    this.darkDividerColor = const Color(0xff313131),
    this.darkPrimaryTextColor = const Color(0xffb4b4b6),
    this.darkSecondaryTextColor = const Color(0xff878787),
    this.darkButtonTextColor = Colors.white,
  });

  final Color lightThemeColor;
  final Color lightPrimaryColor;
  final Color lightBackgroundColor;
  final Color lightIconUnselectedColor;
  final Color lightDividerColor;
  final Color lightPrimaryTextColor;
  final Color lightSecondaryTextColor;
  final Color lightButtonTextColor;

  final Color darkThemeColor;
  final Color darkPrimaryColor;
  final Color darkBackgroundColor;
  final Color darkIconUnselectedColor;
  final Color darkDividerColor;
  final Color darkPrimaryTextColor;
  final Color darkSecondaryTextColor;
  final Color darkButtonTextColor;
}