import 'dart:async';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:sptimer/common/database/database_factory.dart';
import 'package:sptimer/common/error/errors.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/logger/app_logger.dart';
import 'package:sptimer/config/localization/app_localizations_en.dart';
import 'package:sptimer/data/repositories/tasks_reportage_repository.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/data/models/pomodoro_timer_state.dart';
import 'package:sptimer/data/services/pomodoro_sound_player.dart';
import 'package:sptimer/data/services/pomodoro_timer.dart';
import 'package:sptimer/common/constants/constants.dart';
import 'package:sptimer/common/database/database.dart';

const _startEvent = 'start';
const _pausePause = 'pause';
const _resumeEvent = 'resume';
const _finishEvent = 'finish';
const _restartEvent = 'restart';
const _disposeEvent = 'dispose';
const _getStateEvent = 'getState';
const _serviceStartedEvent = 'service_started';
const _getStateResponse = 'getStateResponse';
const _getStateStreamResponse = 'getStateStreamResponse';

final class PomodoroTimerService {
  final _service = FlutterBackgroundService();
  final _controller = StreamController<PomodoroTimerState>.broadcast();

  Future<void> init() async {
    await _service.configure(
      iosConfiguration: IosConfiguration(autoStart: false),
      androidConfiguration: AndroidConfiguration(
        autoStart: false,
        onStart: onStart,
        initialNotificationTitle: 'SPTimer',
        initialNotificationContent: 'Pomodoro Timer Service is running',
        isForegroundMode: true,
        autoStartOnBoot: false,
      ),
    );

    _service.on(_getStateStreamResponse).listen((data) {
      try {
        final state = PomodoroTimerState.fromJson(data!);
        _controller.add(state);
      } catch (e) {
        _handleError(e);
      }
    });
  }

  Future<PomodoroTimerState?> get state async {
    try {
      if (!await _service.isRunning()) return null;
      _service.invoke(_getStateEvent);
      final stateMap = await _service.on(_getStateResponse).first.timeout(
            Duration(seconds: 5),
          );
      if (stateMap == null) return null;

      return PomodoroTimerState.fromJson(stateMap);
    } catch (e) {
      _handleError(e);
      return null;
    }
  }

  void _handleError(Object e) {
    _controller.addError(PomodoroTimerServiceError.fromUnknown(e));
  }

  Stream<PomodoroTimerState> get stateStream {
    return _controller.stream;
  }

  Future<void> start(Task task) async {
    try {
      await _service.startService();
      await _service.on(_serviceStartedEvent).first.timeout(
            Duration(seconds: 7),
          );
      _service.invoke(_startEvent, task.toJson());
    } catch (e) {
      _handleError(e);
    }
  }

  void pause() {
    try {
      _service.invoke(_pausePause);
    } catch (e) {
      _handleError(e);
    }
  }

  void resume() {
    try {
      _service.invoke(_resumeEvent);
    } catch (e) {
      _handleError(e);
    }
  }

  void finish() {
    try {
      _service.invoke(_finishEvent);
    } catch (e) {
      _handleError(e);
    }
  }

  void restart() {
    try {
      _service.invoke(_restartEvent);
    } catch (e) {
      _handleError(e);
    }
  }

  void dispose() {
    try {
      _service.invoke(_disposeEvent);
    } catch (e) {
      _handleError(e);
    }
  }
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  service.invoke(_serviceStartedEvent);
  (service as AndroidServiceInstance).setForegroundNotificationInfo(
    title: 'SPTimer',
    content: 'Pomodoro Timer Service is running',
  );
  await Hive.initFlutter();
  late final PomodoroTimer timer;

  service.on(_startEvent).listen((event) async {
    final task = Task.fromJson(event!);

    timer = PomodoroTimer(
      task: task,
      soundPlayer: PomodoroSoundPlayer(),
      tasksReportageDatabase: TasksReportageRepository(
        await DatabaseFactory.createAdvanced(Constants.taskReportageDB),
      ),
    );

    timer.start();

    timer.streamState.listen((state) {
      // final title = 'Task: ${state.task.title}';
      // final statusText = state.getPomodoroText(AppLocalizationsEn());
      // final remainingTime = 'Remaining Duration: ${state.remainingDuration.formatRemainingTime}';
      // (service as AndroidServiceInstance).setForegroundNotificationInfo(
      //   title: 'SPTimer',
      //   content: '$title\n$statusText\n$remainingTime',
      // );
      final remainingTime = 'Remaining Duration: ${state.remainingDuration.formatRemainingTime}';
      (service as AndroidServiceInstance).setForegroundNotificationInfo(
        title: 'SPTimer',
        content: remainingTime,
      );
      service.invoke(_getStateStreamResponse, state.toJson());
    });
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
    service.invoke(_getStateResponse, timer.state.toJson());
  });
}

base class PomodoroTimerServiceError extends AppError {
  PomodoroTimerServiceError(super.message);

  factory PomodoroTimerServiceError.fromUnknown(Object? e) {
    return e is PomodoroTimerServiceError ? e : PomodoroTimerServiceError(e.toString());
  }
}
