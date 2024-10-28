import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/data/models/task_reportage.dart';
import 'package:sptimer/data/repositories/tasks_reportage_repository.dart';
import 'package:sptimer/data/repositories/tasks_repository.dart';

part 'tasks_state.dart';

final class TasksCubit extends Cubit<TasksState> {
  TasksCubit({
    required TasksRepository tasksRepository,
    required TasksReportageRepository reportageRepository,
  })  : _tasksRepository = tasksRepository,
        _reportageRepository = reportageRepository,
        super(TasksLoadInProgress());

  final TasksRepository _tasksRepository;
  final TasksReportageRepository _reportageRepository;

  Future<void> load() async {
    emit(TasksLoadInProgress());

    final tasks = await _tasksRepository.getAll();
    final todayReportages = await _reportageRepository.getTodayReportages();

    if (tasks.isFailure || todayReportages.isFailure) {
      final e = tasks.errorOrNull ?? todayReportages.error;
      return emit(TasksLoadFailure(e));
    }

    final newState = _separateCompletedAndRemainingTasks(tasks.value, todayReportages.value);
    emit(newState);
  }

  Future<void> delete(String taskId) async {
    if (state is! TasksLoadSuccess) return;

    final taskResult = await _tasksRepository.delete(taskId);
    final reportageResult = await _reportageRepository.delete(taskId);

    if (taskResult.isFailure || reportageResult.isFailure) {
      final e = taskResult.errorOrNull ?? reportageResult.error;
      return emit(TasksLoadFailure(e));
    }

    final newState = _removeTaskFromState(taskId);
    emit(newState);
  }

  TasksLoadSuccess _removeTaskFromState(String taskId) {
    final tasks = List.of((state as TasksLoadSuccess).tasks);
    final remainingTasks = List.of((state as TasksLoadSuccess).remainingTasks);
    final completedTasks = List.of((state as TasksLoadSuccess).completedTasks);

    tasks.removeWhere((value) => value.id == taskId);
    remainingTasks.removeWhere((value) => value.id == taskId);
    completedTasks.removeWhere((value) => value.id == taskId);

    return TasksLoadSuccess(
      tasks: tasks,
      remainingTasks: remainingTasks,
      completedTasks: completedTasks,
    );
  }

  TasksLoadSuccess _separateCompletedAndRemainingTasks(
    List<Task> tasks,
    List<TaskReportage> todayReportages,
  ) {
    final remainingTasks = <Task>[];
    final completedTasks = <Task>[];

    for (final task in tasks) {
      final isCompleted = todayReportages.any(
        (value) => value.taskId == task.id && value.taskStatus.isCompleted,
      );
      if (isCompleted) {
        completedTasks.add(task);
      } else {
        remainingTasks.add(task);
      }
    }

    return TasksLoadSuccess(
      tasks: tasks,
      remainingTasks: completedTasks,
      completedTasks: remainingTasks,
    );
  }
}
