import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/static/static.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(this._service) {
    _loadTheme();
  }

  final PreferencesService _service;

  PlatescapeThemeMode _themeMode = PlatescapeThemeMode.system;
  PlatescapeThemeMode get themeMode => _themeMode;

  String _message = "";
  String get message => _message;

  Future<void> saveTheme(PlatescapeThemeMode mode) async {
    try {
      _themeMode = mode;
      await _service.saveTheme(mode);
    } catch (e) {
      _message = "Failed to save theme configuration";
    }
    notifyListeners();
  }

  void _loadTheme() {
    try {
      _themeMode = _service.getTheme();
      _message = "Successfully loads theme configuration";
    } catch (e) {
      _message = "Failed while loading theme configuration";
    }
    notifyListeners();
  }

  ThemeMode get currentThemeMode {
    switch (_themeMode) {
      case PlatescapeThemeMode.dark:
        return ThemeMode.dark;

      case PlatescapeThemeMode.light:
        return ThemeMode.light;

      case PlatescapeThemeMode.system:
        return ThemeMode.system;
    }
  }
}
