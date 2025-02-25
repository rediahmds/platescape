import 'package:flutter/material.dart';
import 'package:platescape/providers/providers.dart';
import 'package:provider/provider.dart';

class PreviewNotificationTile extends StatelessWidget {
  const PreviewNotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Preview Reminder"),
      subtitle: const Text("Display a notification like the lunch reminder"),
      trailing: OutlinedButton(
        onPressed: () async {
          final duration = Duration(seconds: 3);
          final notificationProvider = context.read<NotificationProvider>();
          final message =
              "A preview notification will appear in ${duration.inSeconds} seconds.";

          _showSnackBar(context, message);
          await notificationProvider.showTestNotification(duration);
        },
        child: const Text("Show me"),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snacbar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacbar);
  }
}
