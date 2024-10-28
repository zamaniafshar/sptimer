part of 'pomodoro_tasks_cubit.dart';

sealed class PomodoroTasksState extends Equatable {
  @override
  List<Object> get props => [];
}

final class PomodoroTasksLoadInProgress extends PomodoroTasksState {}

final class PomodoroTasksLoadFailure extends PomodoroTasksState {
  PomodoroTasksLoadFailure(this.e);

  final Exception e;

  @override
  List<Object> get props => [e];
}

final class PomodoroTasksLoadSuccess extends PomodoroTasksState {
  PomodoroTasksLoadSuccess({
    required this.tasks,
    required this.remainingTasks,
    required this.completedTasks,
  });

  final List<PomodoroTask> tasks;
  final List<PomodoroTask> remainingTasks;
  final List<PomodoroTask> completedTasks;

  @override
  List<Object> get props => [
        tasks,
        remainingTasks,
        completedTasks,
      ];
}
