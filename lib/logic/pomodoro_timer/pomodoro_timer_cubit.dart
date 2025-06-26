import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sptimer/data/enums/pomodoro_status.dart';
import 'package:sptimer/data/enums/timer_status.dart';
import 'package:sptimer/data/models/pomodoro_timer_state.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/data/services/pomodoro_timer_service.dart';
import 'package:sptimer/common/streamable_cubit.dart';

final class PomodoroTimerCubit extends StreamableCubit<PomodoroTimerState> {
  PomodoroTimerCubit({
    required PomodoroTimerService timer,
    required Task task,
  })  : _timer = timer,
        super(PomodoroTimerState.initial(task: task)) {
    forEach(
      _timer.stateStream,
      onData: (timerState) {
        return timerState;
      },
    );
  }

  final PomodoroTimerService _timer;

  Future<void> start() async {
    await _timer.start(state.task);
  }

  void pause() {
    _timer.pause();
  }

  void resume() {
    _timer.resume();
  }

  void finish() {
    _timer.finish();
  }

  void restart() {
    _timer.restart();
  }
}
