part of 'tasks_cubit.dart';

sealed class TasksState extends Equatable {
  @override
  List<Object> get props => [];
}

final class TasksLoadInProgress extends TasksState {}

final class TasksLoadFailure extends TasksState {
  TasksLoadFailure(this.e);

  final Exception e;

  @override
  List<Object> get props => [e];
}

final class TasksLoadSuccess extends TasksState {
  TasksLoadSuccess({
    required this.tasks,
    required this.remainingTasks,
    required this.completedTasks,
  });

  final List<Task> tasks;
  final List<Task> remainingTasks;
  final List<Task> completedTasks;

  @override
  List<Object> get props => [
        tasks,
        remainingTasks,
        completedTasks,
      ];
}
