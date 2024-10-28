import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sptimer/data/models/pomodoro_task.dart';
import 'package:sptimer/data/models/pomodoro_task_reportage.dart';
import 'package:sptimer/data/repositories/pomodoro_tasks_reportage_repository.dart';
import 'package:sptimer/data/repositories/pomodoro_tasks_repository.dart';

part 'pomodoro_tasks_state.dart';

final class PomodoroTasksCubit extends Cubit<PomodoroTasksState> {
  PomodoroTasksCubit({
    required PomodoroTasksRepository tasksRepository,
    required PomodoroTasksReportageRepository reportageRepository,
  })  : _tasksRepository = tasksRepository,
        _reportageRepository = reportageRepository,
        super(PomodoroTasksLoadInProgress());

  final PomodoroTasksRepository _tasksRepository;
  final PomodoroTasksReportageRepository _reportageRepository;

  Future<void> load() async {
    emit(PomodoroTasksLoadInProgress());

    final tasks = await _tasksRepository.getAll();
    final todayReportages = await _reportageRepository.getTodayReportages();

    if (tasks.isFailure || todayReportages.isFailure) {
      final e = tasks.errorOrNull ?? todayReportages.error;
      return emit(PomodoroTasksLoadFailure(e));
    }

    final newState = _separateCompletedAndRemainingTasks(tasks.value, todayReportages.value);
    emit(newState);
  }

  Future<void> delete(String taskId) async {
    if (state is! PomodoroTasksLoadSuccess) return;

    final taskResult = await _tasksRepository.delete(taskId);
    final reportageResult = await _reportageRepository.delete(taskId);

    if (taskResult.isFailure || reportageResult.isFailure) {
      final e = taskResult.errorOrNull ?? reportageResult.error;
      return emit(PomodoroTasksLoadFailure(e));
    }

    final newState = _removeTaskFromState(taskId);
    emit(newState);
  }

  PomodoroTasksLoadSuccess _removeTaskFromState(String taskId) {
    final tasks = List.of((state as PomodoroTasksLoadSuccess).tasks);
    final remainingTasks = List.of((state as PomodoroTasksLoadSuccess).remainingTasks);
    final completedTasks = List.of((state as PomodoroTasksLoadSuccess).completedTasks);

    tasks.removeWhere((value) => value.id == taskId);
    remainingTasks.removeWhere((value) => value.id == taskId);
    completedTasks.removeWhere((value) => value.id == taskId);

    return PomodoroTasksLoadSuccess(
      tasks: tasks,
      remainingTasks: remainingTasks,
      completedTasks: completedTasks,
    );
  }

  PomodoroTasksLoadSuccess _separateCompletedAndRemainingTasks(
    List<PomodoroTask> tasks,
    List<PomodoroTaskReportage> todayReportages,
  ) {
    final remainingTasks = <PomodoroTask>[];
    final completedTasks = <PomodoroTask>[];

    for (final task in tasks) {
      final isCompleted = todayReportages.any(
        (value) => value.pomodoroTaskId == task.id && value.taskStatus.isCompleted,
      );
      if (isCompleted) {
        completedTasks.add(task);
      } else {
        remainingTasks.add(task);
      }
    }

    return PomodoroTasksLoadSuccess(
      tasks: tasks,
      remainingTasks: completedTasks,
      completedTasks: remainingTasks,
    );
  }
}
