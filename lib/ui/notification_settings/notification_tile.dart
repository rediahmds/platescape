import 'package:flutter/material.dart';
import 'package:platescape/providers/providers.dart';
import 'package:provider/provider.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    this.title = _tileTitle,
    this.subtitle = _tileSubtitle,
  });

  final String title;
  final String subtitle;

  static const String _tileTitle = "Lunch Reminder";
  static const String _tileSubtitle = "Get notified when it's time for lunch";

  @override
  Widget build(BuildContext context) {
    final notificationProvider = context.watch<NotificationProvider>();

    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: notificationProvider.isNotificationEnabled,
        onChanged: (value) {
          notificationProvider.toggleNotification(value);
        },
      ),
    );
  }
}
