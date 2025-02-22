import 'package:platescape/static/static.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  const SharedPreferencesService(this._preferences);
  final SharedPreferences _preferences;

  static const String _themeModeKey = "themeMode";

  Future<void> saveTheme(PlatescapeThemeMode mode) async {
    try {
      await _preferences.setString(_themeModeKey, mode.name);
    } catch (e) {
      throw Exception("Failed to save theme settings.");
    }
  }

  PlatescapeThemeMode getTheme() {
    final defaultMode = PlatescapeThemeMode.system;
    final storedMode = _preferences.getString(_themeModeKey);

    return PlatescapeThemeMode.values.firstWhere(
      (mode) => mode.name == storedMode,
      orElse: () => defaultMode,
    );
  }
}
