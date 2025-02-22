import 'package:flutter/material.dart';

class ThemeTile extends StatelessWidget {
  const ThemeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Theme"),
      subtitle: const Text("System default"),
      onTap: () {
        debugPrint("Setting theme...");
      },
    );
  }
}
