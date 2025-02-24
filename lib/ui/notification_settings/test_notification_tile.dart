import 'package:flutter/material.dart';
import 'package:platescape/providers/providers.dart';
import 'package:provider/provider.dart';

class TestNotificationTile extends StatelessWidget {
  const TestNotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Test Reminder"),
      subtitle: const Text("Show a similar notification to the lunch reminder"),
      trailing: OutlinedButton(
        onPressed: () async {
          final duration = Duration(seconds: 3);
          final notificationProvider = context.read<NotificationProvider>();

          _showSnackBar(context, duration);
          await notificationProvider.showTestNotification(duration);
        },
        child: const Text("Show me"),
      ),
    );
  }

  void _showSnackBar(BuildContext context, Duration duration) {
    final snacbar = SnackBar(
      content: Text(
          "Test reminder notification will be shown in ${duration.inSeconds.toString()} seconds"),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacbar);
  }
}
