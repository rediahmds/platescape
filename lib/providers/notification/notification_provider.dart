import 'package:flutter/widgets.dart';
import 'package:platescape/data/data.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider(this._notificationService);
  final NotificationService _notificationService;

  int _notificationId = 0;

  bool _permission = false;
  bool get permission => _permission;

  Future<void> showDailyNotification() async {
    _notificationId++;
    await _notificationService.scheduleDailyNotification(
      id: _notificationId,
    );
  }
}
