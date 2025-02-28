import 'package:platescape/data/data.dart';
import 'package:platescape/static/static.dart';
import 'package:workmanager/workmanager.dart';

@pragma("vm:entry-point")
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
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
  final bool isDebugMode = true;

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
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      initialDelay: const Duration(seconds: 5),
      inputData: {
        "data": "Payload from $uniqueName",
      },
    );
  }

  Future<void> runPeriodicTask() async {
    final uniqueName = PlatescapeWorkmanager.periodic.uniqueName;
    final taskName = PlatescapeWorkmanager.periodic.taskName;

    final now = DateTime.now();
    final defaultHour = 11;
    final defaultMinute = 0;
    final defaultSchedule = DateTime(
      now.year,
      now.month,
      now.day,
      defaultHour,
      defaultMinute,
    );
    final initialDelay = defaultSchedule.difference(now);

    await _workmanager.registerPeriodicTask(
      uniqueName,
      taskName,
      frequency: const Duration(hours: 24),
      initialDelay: initialDelay,
      inputData: {
        "data": "Payload from $uniqueName",
      },
    );
  }

  Future<void> cancelAllTasks() async {
    await _workmanager.cancelAll();
  }
}
