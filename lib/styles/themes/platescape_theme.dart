import 'package:flutter/material.dart';
import 'package:platescape/styles/styles.dart';

class PlatescapeTheme {
  static TextTheme get _textTheme => PlatescapeTypograph.platescapeTextTheme;

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      toolbarTextStyle: _textTheme.titleLarge,
      centerTitle: true,
    );
  }

  static ThemeData get lightTheme {
    final preferredTextColor = Colors.black87;
    return ThemeData(
      colorSchemeSeed: PlatescapeColors.green.color,
      brightness: Brightness.light,
      useMaterial3: true,
      textTheme: _textTheme.apply(
        displayColor: preferredTextColor,
        bodyColor: preferredTextColor,
      ),
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get darkTheme {
    final preferredTextColor = Colors.white70;
    return ThemeData(
      colorSchemeSeed: PlatescapeColors.green.color,
      brightness: Brightness.dark,
      useMaterial3: true,
      textTheme: _textTheme.apply(
        displayColor: preferredTextColor,
        bodyColor: preferredTextColor,
      ),
      appBarTheme: _appBarTheme,
    );
  }
}
