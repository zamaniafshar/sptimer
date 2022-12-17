import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:pomotimer/data/databases/pomodoro_state_database.dart';
import 'package:pomotimer/data/databases/tasks_reportage_database.dart';
import 'package:pomotimer/data/models/pomodoro_app_state_data.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/timers/pomodoro_task_timer.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:pomotimer/utils/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

void onForegroundServiceStart(ServiceInstance service) async {
  updatePomodoroNotification(service);
  service.invoke('started');
  final Map<String, dynamic>? initState = await service.on('initData').first;
  final data = PomodoroAppSateData.fromMap(initState!);
  TasksReportageDatabase tasksReportageDatabase = TasksReportageDatabase();
  await Hive.initFlutter();
  tasksReportageDatabase.init();
  PomodoroTaskTimer timer = PomodoroTaskTimer(
    tasksReportageDatabase: tasksReportageDatabase,
    taskReportageModel: data.pomodoroTaskReportageModel!,
  );
  timer.init(
    initState: data.pomodoroTaskModel,
    onFinish: () async {
      final stateDataBase = PomodoroStateDatabase();
      await stateDataBase.init();
      stateDataBase.save(timer.pomodoroAppSateData);
      await Hive.close();
      service.stopSelf();
    },
  );
  timer.start();
  timer.listen(() {
    updatePomodoroNotification(service, timer.pomodoroTask);
  });

  service.on('getData').listen((event) {
    service.invoke('sendData', timer.pomodoroAppSateData.toMap());
  });

  service.on(kStopServiceKey).listen((event) {
    timer.cancel();
    service.stopSelf();
  });
}

void updatePomodoroNotification(ServiceInstance service, [PomodoroTaskModel? state]) {
  (service as AndroidServiceInstance).setForegroundNotificationInfo(
    title: state?.title ?? 'PomoTimer',
    content: state?.remainingDuration.toString().substring(2, 7) ?? 'started',
  );
}
