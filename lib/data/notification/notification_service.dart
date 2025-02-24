import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() {
    return _instance;
  }
  NotificationService._internal();

  final _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final androidSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    final initilizationSettings = InitializationSettings(
      android: androidSettings,
    );

    await _plugin.initialize(initilizationSettings);
  }

  Future<bool> _isAndroidPermissionGranted() async {
    final isGranted = await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled();

    return isGranted ?? false;
  }

  Future<bool> _requestAndroidNotificationPermission() async {
    final isPermitted = await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    return isPermitted ?? false;
  }

  Future<bool> _requestAndroidExactAlarmsPermission() async {
    final isPermitted = await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();

    return isPermitted ?? false;
  }

  Future<bool> _requestAndroidPermissions() async {
    final isNotificationGranted = await _isAndroidPermissionGranted();
    final isAlarmGranted = await _requestAndroidExactAlarmsPermission();

    if (!isNotificationGranted) {
      final isNotificationPermitted =
          await _requestAndroidNotificationPermission();

      return isNotificationPermitted && isAlarmGranted;
    }
    return isNotificationGranted && isAlarmGranted;
  }

  Future<bool> requestPlatformPermission() async {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        final isAndroidFullyPermitted = await _requestAndroidPermissions();
        return isAndroidFullyPermitted;

      default:
        return false;
    }
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final timeZoneName = await FlutterTimezone.getLocalTimezone();
    final location = tz.getLocation(timeZoneName);
    tz.setLocalLocation(location);
  }

  tz.TZDateTime defaultScheduleDateTime() {
    final now = tz.TZDateTime.now(tz.local);
    final defaultHour = 11;
    tz.TZDateTime defaultSchedule = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      defaultHour,
    );

    final isPast = defaultSchedule.isBefore(now);
    if (isPast) {
      defaultSchedule = defaultSchedule.add(const Duration(days: 1));
    }

    return defaultSchedule;
  }

  Future<void> scheduleDailyNotification({
    required int id,
    String channelId = "daily_notification",
    String channelName = "Daily Notification",
    String channelDescription = "Daily lunch reminder at specified time",
  }) async {
    final androidChannel = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: "ticker",
    );

    final notificationTitle = "Lunch Time!";
    final notificationBody = "It's time to have your lunch! 🍛";
    final selectedSchedule = defaultScheduleDateTime();
    final notificationDetails = NotificationDetails(android: androidChannel);

    await _plugin.zonedSchedule(
      id,
      notificationTitle,
      notificationBody,
      selectedSchedule,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    final pendingNotifications = await _plugin.pendingNotificationRequests();
    return pendingNotifications;
  }

  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }
}
