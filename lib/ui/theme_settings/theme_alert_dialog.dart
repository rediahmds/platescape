import 'package:flutter/material.dart';
import 'package:platescape/static/static.dart';
import 'package:platescape/ui/ui.dart';

class ThemeAlertDialog extends StatelessWidget {
  const ThemeAlertDialog({super.key, required this.dialogTitle});
  final String dialogTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(dialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: PlatescapeThemeMode.values
            .map(
              (themeMode) => ThemeOptionRadioTile(
                themeName: themeMode.name,
                mode: themeMode,
              ),
            )
            .toList(),
      ),
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
