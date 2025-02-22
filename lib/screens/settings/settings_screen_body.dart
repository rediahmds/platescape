import 'package:flutter/material.dart';
import 'package:platescape/ui/theme_settings/theme_settings.dart';

class SettingsScreenBody extends StatelessWidget {
  const SettingsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ThemeTile(),
      ],
    );
  }
}
