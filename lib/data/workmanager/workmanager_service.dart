import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/static/static.dart';
import 'package:workmanager/workmanager.dart';

@pragma("vm:entry-point")
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    debugPrint("DEBUG: executing callbackDispatcher");
    final randomRestaurant = await APIServices().getRandomRestaurant();

    await NotificationService().showNotification(
      restaurant: randomRestaurant,
    );

    return Future.value(true);
  });
}

class WorkmanagerService {
  static final WorkmanagerService _instance = WorkmanagerService._internal();
  factory WorkmanagerService() {
    return _instance;
  }
  WorkmanagerService._internal();

  static final Workmanager _workmanager = Workmanager();
  final bool isDebugMode = false;

  Future<void> init() async {
    await _workmanager.initialize(
      callbackDispatcher,
      isInDebugMode: isDebugMode,
    );
  }

  Future<void> runOneOffTask() async {
    final uniqueName = PlatescapeWorkmanager.oneOff.uniqueName;
    final taskName = PlatescapeWorkmanager.oneOff.taskName;

    await _workmanager.registerOneOffTask(
      uniqueName,
      taskName,
      initialDelay: const Duration(seconds: 3),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  Future<void> runPeriodicTask() async {
    final uniqueName = PlatescapeWorkmanager.periodic.uniqueName;
    final taskName = PlatescapeWorkmanager.periodic.taskName;

    final now = DateTime.now();
    final defaultHour = 11;
    final defaultMinute = 0;
    DateTime defaultSchedule = DateTime(
      now.year,
      now.month,
      now.day,
      defaultHour,
      defaultMinute,
    );

    final isPast = defaultSchedule.isBefore(now);
    if (isPast) {
      defaultSchedule = defaultSchedule.add(const Duration(days: 1));
    }
    final initialDelay = defaultSchedule.difference(now);


    await _workmanager.registerPeriodicTask(
      uniqueName,
      taskName,
      frequency: const Duration(days: 1),
      initialDelay: initialDelay,
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }

  Future<void> cancelAllTasks() async {
    await _workmanager.cancelAll();
  }
}
