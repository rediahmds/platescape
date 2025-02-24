import 'package:flutter/material.dart';
import 'package:platescape/ui/ui.dart';

class SettingsScreenBody extends StatelessWidget {
  const SettingsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ThemeTile(),
        NotificationTile(),
      ],
    );
  }
}
