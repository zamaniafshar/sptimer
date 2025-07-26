import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sptimer/config/localization/app_localizations.dart';
import 'package:sptimer/data/enums/pomodoro_status.dart';
import 'package:sptimer/data/enums/timer_status.dart';
import 'package:sptimer/data/models/task.dart';

part 'pomodoro_timer_state.freezed.dart';
part 'pomodoro_timer_state.g.dart';

@freezed
abstract class PomodoroTimerState with _$PomodoroTimerState {
  const factory PomodoroTimerState({
    required Task task,
    required TimerStatus timerStatus,
    required PomodoroStatus pomodoroStatus,
    required int pomodoroRound,
    required Duration elapsedTime,
  }) = _PomodoroTimerState;

  factory PomodoroTimerState.initial({
    required Task task,
  }) =>
      PomodoroTimerState(
        task: task,
        timerStatus: TimerStatus.finished,
        pomodoroStatus: PomodoroStatus.work,
        pomodoroRound: 1,
        elapsedTime: Duration.zero,
      );

  factory PomodoroTimerState.fromJson(Map<String, dynamic> json) =>
      _$PomodoroTimerStateFromJson(json);
}

extension PomodoroTimerStateExt on PomodoroTimerState {
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
  String getPomodoroText(AppLocalizations localization) {
    final workMinutes = task.workDuration.inMinutes;
    final shortBreakMinutes = task.shortBreakDuration.inMinutes;
    final longBreakMinutes = task.longBreakDuration.inMinutes;

    return switch (pomodoroStatus) {
      PomodoroStatus.work => localization.workTimeDescription(workMinutes),
      PomodoroStatus.shortBreak => localization.shortBreakDescription(shortBreakMinutes),
      PomodoroStatus.longBreak => localization.longBreakDescription(longBreakMinutes),
    };
  }
}
