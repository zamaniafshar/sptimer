import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sptimer/data/repositories/tasks_reportage_repository.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/data/models/pomodoro_timer_state.dart';
import 'package:sptimer/data/services/pomodoro_sound_player.dart';
import 'package:sptimer/data/services/pomodoro_timer.dart';
import 'package:sptimer/common/constants/constants.dart';
import 'package:sptimer/common/database.dart';

const _startEvent = 'start';
const _pausePause = 'pause';
const _resumeEvent = 'resume';
const _finishEvent = 'finish';
const _restartEvent = 'restart';
const _disposeEvent = 'dispose';
const _getStateEvent = 'getState';
const _getStateResponse = 'getStateResponse';
const _getStateStreamResponse = 'getStateStreamResponse';

final class PomodoroTimerService {
  final service = FlutterBackgroundService();

  Future<void> init() async {
    await service.configure(
      iosConfiguration: IosConfiguration(autoStart: false),
      androidConfiguration: AndroidConfiguration(
        autoStart: false,
        onStart: onStart,
        isForegroundMode: true,
        autoStartOnBoot: false,
      ),
    );
  }

  Future<PomodoroTimerState> get state async {
    service.invoke(_getStateEvent);
    final stateMap = await service.on(_getStateResponse).first;
    return PomodoroTimerState.fromMap(stateMap!);
  }

  Stream<PomodoroTimerState> get stateStream {
    return service.on(_getStateStreamResponse).map(
          (map) => PomodoroTimerState.fromMap(map!),
        );
  }

  Future<void> start(Task task) async {
    await service.startService();
    service.invoke(_startEvent, task.toMap());
  }

  void pause() {
    service.invoke(_pausePause);
  }

  void resume() {
    service.invoke(_resumeEvent);
  }

  void finish() {
    service.invoke(_finishEvent);
  }

  void restart() {
    service.invoke(_restartEvent);
  }

  void dispose() {
    service.invoke(_disposeEvent);
  }
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  await Hive.initFlutter();
  late final PomodoroTimer timer;

  service.on(_startEvent).listen((event) async {
    final task = Task.fromMap(event!);

    timer = PomodoroTimer(
      task: task,
      soundPlayer: PomodoroSoundPlayer(),
      tasksReportageDatabase: TasksReportageRepository(
        await Database.open(Constants.taskReportageDB),
      ),
    );

    timer.start();
  });

  service.on(_pausePause).listen((event) {
    timer.pause();
  });

  service.on(_resumeEvent).listen((event) {
    timer.resume();
  });

  service.on(_finishEvent).listen((event) {
    timer.finish();
    timer.dispose();
    service.stopSelf();
  });

  service.on(_disposeEvent).listen((event) {
    timer.dispose();
    service.stopSelf();
  });

  service.on(_restartEvent).listen((event) {
    timer.restart();
  });

  service.on(_getStateEvent).listen((event) {
    service.invoke(_getStateResponse, timer.state.toMap());
  });

  timer.streamState.listen((state) {
    service.invoke(_getStateStreamResponse, state.toMap());
  });
}
