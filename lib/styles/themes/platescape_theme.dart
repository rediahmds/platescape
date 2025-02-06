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
    return ThemeData(
      colorSchemeSeed: PlatescapeColors.green.color,
      brightness: Brightness.light,
      useMaterial3: true,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: PlatescapeColors.green.color,
      brightness: Brightness.dark,
      useMaterial3: true,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
    );
  }
}
