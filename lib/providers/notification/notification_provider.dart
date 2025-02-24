import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:platescape/data/data.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider(this._notificationService, this._preferencesService) {
    _loadNotificationStatus();
  }

  // TODO: Refactor to implement try catch block

  final NotificationService _notificationService;
  final PreferencesService _preferencesService;

  int _notificationId = 0;

  bool _permission = false;
  bool get permission => _permission;

  bool _isNotificationEnabled = false;
  bool get isNotificationEnabled => _isNotificationEnabled;

  String _message = "";
  String get message => _message;

  List<PendingNotificationRequest> _pendingNotifications = [];
  List<PendingNotificationRequest> get pendingNotifications =>
      _pendingNotifications;

  void _loadNotificationStatus() {
    _isNotificationEnabled = _preferencesService.getNotification();
    notifyListeners();
  }

  Future<void> toggleNotification(bool value) async {
    _isNotificationEnabled = value;
    await _preferencesService.saveNotification(value);

    if (_isNotificationEnabled) {
      await _scheduleDailyNotification();
    } else {
      await cancelAllNotifications();
    }

    notifyListeners();
  }

  Future<void> _scheduleDailyNotification() async {
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
