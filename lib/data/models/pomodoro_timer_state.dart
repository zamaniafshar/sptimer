import 'package:dart_mappable/dart_mappable.dart';
import 'package:sptimer/data/enums/pomodoro_status.dart';
import 'package:sptimer/data/enums/timer_status.dart';
import 'package:sptimer/data/models/task.dart';

part 'pomodoro_timer_state.mapper.dart';

@MappableClass()
final class PomodoroTimerState with PomodoroTimerStateMappable {
  const PomodoroTimerState({
    required this.task,
    required this.timerStatus,
    required this.pomodoroStatus,
    required this.pomodoroRound,
    required this.elapsedTime,
  });

  const PomodoroTimerState.initial({
    required this.task,
  })  : timerStatus = TimerStatus.finished,
        pomodoroStatus = PomodoroStatus.work,
        pomodoroRound = 1,
        elapsedTime = Duration.zero;

  final Task task;
  final TimerStatus timerStatus;
  final PomodoroStatus pomodoroStatus;
  final int pomodoroRound;
  final Duration elapsedTime;

  Duration get currentMaxDuration {
    if (pomodoroStatus.isWorkTime) {
      return task.workDuration;
    } else if (pomodoroStatus.isShortBreakTime) {
      return task.shortBreakDuration;
    } else {
      return task.longBreakDuration;
    }
  }

  Duration get remainingDuration => currentMaxDuration - elapsedTime;

  factory PomodoroTimerState.fromMap(Map<String, dynamic> map) =>
      PomodoroTimerStateMapper.fromMap(map);
}
