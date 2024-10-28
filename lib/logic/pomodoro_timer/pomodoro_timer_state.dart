part of 'pomodoro_timer_cubit.dart';

final class PomodoroTimerState extends Equatable {
  const PomodoroTimerState({
    required this.task,
    required this.timerStatus,
    required this.pomodoroStatus,
    required this.pomodoroRound,
    required this.currentMaxDuration,
    required this.remainingDuration,
  });

  PomodoroTimerState.initial({
    required this.task,
  })  : timerStatus = TimerStatus.finished,
        pomodoroStatus = PomodoroStatus.work,
        pomodoroRound = 1,
        currentMaxDuration = task.workDuration,
        remainingDuration = task.workDuration;

  final PomodoroTask task;
  final TimerStatus timerStatus;
  final PomodoroStatus pomodoroStatus;
  final int pomodoroRound;
  final Duration currentMaxDuration;
  final Duration remainingDuration;

  @override
  List<Object?> get props => [
        task,
        timerStatus,
        pomodoroStatus,
        pomodoroRound,
        currentMaxDuration,
        remainingDuration,
      ];
}
