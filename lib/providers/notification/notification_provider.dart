import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:platescape/data/data.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider(this._notificationService);
  final NotificationService _notificationService;

  int _notificationId = 0;

  bool _permission = false;
  bool get permission => _permission;

  List<PendingNotificationRequest> _pendingNotifications = [];
  List<PendingNotificationRequest> get pendingNotifications =>
      _pendingNotifications;

  Future<void> scheduleDailyNotification() async {
    _notificationId++;
    await _notificationService.scheduleDailyNotification(
      id: _notificationId,
    );
  }

  Future<void> getPendingNotifications() async {
    _pendingNotifications =
        await _notificationService.getPendingNotifications();

    notifyListeners();
  }

  Future<void> cancelNotification(int id) async {
    await _notificationService.cancelNotification(id);
  }

  Future<void> cancelAllNotifications() async {
    await _notificationService.cancelAllNotifications();
  }
}
