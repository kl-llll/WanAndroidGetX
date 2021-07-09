import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  Color get accentColor => theme.accentColor;
  Color get canvasColor => theme.canvasColor;
  Color get primaryColor => theme.primaryColor;
  Color get shadowColor => theme.shadowColor;


}
