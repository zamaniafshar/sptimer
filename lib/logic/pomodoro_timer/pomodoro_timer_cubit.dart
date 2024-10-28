import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:sptimer/data/enums/pomodoro_status.dart';
import 'package:sptimer/data/enums/timer_status.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/data/services/pomodoro_timer_service.dart';
import 'package:sptimer/utils/streamable_cubit.dart';

part 'pomodoro_timer_state.dart';

final class PomodoroTimerCubit extends StreamableCubit<PomodoroTimerState> {
  PomodoroTimerCubit({
    required PomodoroTimerService timer,
    required Task task,
  })  : _timer = timer,
        super(PomodoroTimerState.initial(task: task)) {
    forEach(
      _timer.stateStream,
      onData: (timerState) {
        return PomodoroTimerState(
          task: timerState.task,
          timerStatus: timerState.timerStatus,
          pomodoroStatus: timerState.pomodoroStatus,
          pomodoroRound: timerState.pomodoroRound,
          currentMaxDuration: timerState.currentMaxDuration,
          remainingDuration: timerState.remainingDuration,
        );
      },
    );
  }

  final PomodoroTimerService _timer;

  Future<void> start(Task task) async {
    await _timer.start(task);
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
