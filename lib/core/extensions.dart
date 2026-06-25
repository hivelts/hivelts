import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get hourAmPm {
    return DateFormat('hh:mm a').format(this);
  }
}

extension AppColorsExtension on BuildContext {
  Color get darkOrLightColor => isDark ? Colors.white : Colors.black;
}

extension ThemeExtension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  bool get isLight => !isDark;
}
