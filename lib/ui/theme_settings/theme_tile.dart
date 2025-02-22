import 'package:flutter/material.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/ui/ui.dart';
import 'package:provider/provider.dart';

class ThemeTile extends StatelessWidget {
  const ThemeTile({super.key});

  static const String _tileTitle = "Theme";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_tileTitle),
      subtitle: Text(
        context.watch<ThemeProvider>().themeMode.name,
      ),
      onTap: () {
        _showThemeAlertDialog(context, _tileTitle);
      },
    );
  }

  void _showThemeAlertDialog(BuildContext context, String dialogTitle) {
    showDialog(
      context: context,
      builder: (context) => ThemeAlertDialog(dialogTitle: dialogTitle),
    );
  }
}
