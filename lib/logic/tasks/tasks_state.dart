part of 'tasks_cubit.dart';

@freezed
abstract class TasksState with _$TasksState {
  const TasksState._();

  const factory TasksState({
    required bool isLoading,
    required List<Task> tasks,
    required List<Task> remainingTasks,
    required List<Task> completedTasks,
  }) = _TasksState;

  factory TasksState.initial() => TasksState(
        isLoading: true,
        tasks: [],
        remainingTasks: [],
        completedTasks: [],
      );
}
