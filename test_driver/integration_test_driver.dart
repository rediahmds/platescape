import 'dart:io';
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  await Process.run(
    "adb",
    [
      "shell",
      "pm",
      "grant",
      "com.rediahmds.platescape.platescape",
      "android.permission.POST_NOTIFICATIONS",
    ],
  );

  await integrationDriver();
}
