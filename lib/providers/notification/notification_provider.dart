import 'package:flutter/widgets.dart';
import 'package:platescape/data/data.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider(
    this._notificationService,
    this._preferencesService,
    this._workmanagerService,
  ) {
    _loadNotificationStatus();
  }

  final NotificationService _notificationService;
  final PreferencesService _preferencesService;
  final WorkmanagerService _workmanagerService;

  int _notificationId = 0;

  bool _permission = false;
  bool get permission => _permission;

  bool _isNotificationEnabled = false;
  bool get isNotificationEnabled => _isNotificationEnabled;

  String _message = "";
  String get message => _message;

  void _loadNotificationStatus() {
    try {
      _isNotificationEnabled = _preferencesService.getNotification();
      if (_isNotificationEnabled) {
        _scheduleDailyNotification();
      }
    } catch (e) {
      _message = "Failed to load preferences";
    }
    notifyListeners();
  }

  Future<void> requestPlatformPermissions() async {
    try {
      _permission = await _notificationService.requestPlatformPermissions();
    } catch (e) {
      _message = "Failed to request for permissions";
    }
    notifyListeners();
  }

  Future<void> toggleNotification(bool value) async {
    try {
      _isNotificationEnabled = value;
      await _preferencesService.saveNotification(value);

      if (_isNotificationEnabled) {
        await _scheduleDailyNotification();
      } else {
        await cancelAllNotifications();
      }
    } catch (e) {
      _message = "Failed to toggle notification setting";
    }

    notifyListeners();
  }

  Future<void> _scheduleDailyNotification() async {
    _workmanagerService.runPeriodicTask();
  }

  Future<void> showTestNotification(Duration duration) async {
    _notificationId++;
    await _notificationService.scheduleTestNotification(
      id: _notificationId,
      duration: duration,
    );
  }

  Future<void> cancelAllNotifications() async {
    await _notificationService.cancelAllNotifications();
    await _workmanagerService.cancelAllTasks();
  }
}
