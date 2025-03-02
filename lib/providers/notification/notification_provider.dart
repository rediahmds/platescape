import 'package:flutter/widgets.dart';
import 'package:platescape/data/data.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider(
    this._notificationService,
    this._preferencesService,
    this._workmanagerService,
  ) {
    _loadNotificationStatus();
  }

  // TODO: Refactor to implement try catch block

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

  List<PendingNotificationRequest> _pendingNotifications = [];
  List<PendingNotificationRequest> get pendingNotifications =>
      _pendingNotifications;

  void _loadNotificationStatus() {
    _isNotificationEnabled = _preferencesService.getNotification();
    if (_isNotificationEnabled) {
      _scheduleDailyNotification();
    }
    notifyListeners();
  }

  Future<void> requestPlatformPermissions() async {
    _permission = await _notificationService.requestPlatformPermissions();
    notifyListeners();
  }

  Future<void> toggleNotification(bool value) async {
    _isNotificationEnabled = value;
    await _preferencesService.saveNotification(value);

    if (_isNotificationEnabled) {
      await _scheduleDailyNotification();
      _pendingNotifications =
          await _notificationService.getPendingNotifications();
    } else {
      await cancelAllNotifications();
      _pendingNotifications =
          await _notificationService.getPendingNotifications();
    }

    notifyListeners();
  }

  Future<void> _scheduleDailyNotification() async {
    await _workmanagerService.runPeriodicTask();
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
