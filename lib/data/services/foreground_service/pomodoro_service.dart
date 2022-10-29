import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/pomodoro_timer/pomodoro_timer.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:pomotimer/util/util.dart';

void onForegroundServiceStart(ServiceInstance service) async {
  updatePomodoroNotification(service);
  service.invoke('started');
  Map<String, dynamic>? initState = await service.on('initData').first;

  PomodoroTimer timer = PomodoroTimer(
      initState: PomodoroTaskModel.fromMap(initState!),
      onFinish: () async {
        service.stopSelf();
      });
  timer.start();
  timer.listen(() {
    updatePomodoroNotification(service, timer.pomodoroTask);
  });

  service.on('getData').listen((event) {
    service.invoke('sendData', timer.pomodoroTask.toMap());
  });

  service.on(kStopServiceKey).listen((event) {
    service.stopSelf();
  });
}

void updatePomodoroNotification(ServiceInstance service, [PomodoroTaskModel? state]) {
  (service as AndroidServiceInstance).setForegroundNotificationInfo(
    title: state?.title ?? 'PomoTimer',
    content: state?.remainingDuration.toString().substring(2, 7) ?? 'started',
  );
}
