import 'package:flutter/material.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/static/static.dart';
import 'package:provider/provider.dart';

class ThemeOptionRadioTile extends StatelessWidget {
  const ThemeOptionRadioTile({
    super.key,
    required this.themeName,
    required this.mode,
  });

  final String themeName;
  final PlatescapeThemeMode mode;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<PlatescapeThemeMode>(
      title: Text(themeName),
      value: mode,
      groupValue: context.watch<ThemeProvider>().themeMode,
      onChanged: (PlatescapeThemeMode? mode) {
        if (mode != null) {
          context.read<ThemeProvider>().saveTheme(mode);
        }
      },
    );
  }
}
