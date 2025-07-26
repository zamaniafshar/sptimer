import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sptimer/common/events_bus/events.dart';
import 'package:sptimer/common/events_bus/events_bus.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/data/models/task_reportage.dart';
import 'package:sptimer/data/repositories/tasks_reportage_repository.dart';
import 'package:sptimer/data/repositories/tasks_repository.dart';
import 'package:sptimer/common/streamable_cubit.dart';
import 'package:sptimer/common/extensions/extensions.dart';

part 'tasks_state.dart';
part 'tasks_cubit.freezed.dart';

final class TasksCubit extends StreamableCubit<TasksState> {
  TasksCubit({
    required TasksRepository tasksRepository,
    required TasksReportageRepository reportageRepository,
    required RemovedItemBuilder<Task> removeItemBuilder,
  })  : _tasksRepository = tasksRepository,
        _reportageRepository = reportageRepository,
        super(
          TasksState.initial(
            removeItemBuilder: removeItemBuilder,
          ),
        ) {
    _load();

    onEach(EventsBus.on<TaskAddedEvent>(), onData: _onTaskAddedEvent);
    onEach(EventsBus.on<TaskEditedEvent>(), onData: _onTaskEditedEvent);
  }

  final TasksRepository _tasksRepository;
  final TasksReportageRepository _reportageRepository;

  Future<void> delete(String taskId) async {
    await _tasksRepository.delete(taskId);
    await _reportageRepository.deleteTaskReportages(taskId);

    emit(
      state.copyWith(
        completedTasks: state.completedTasks.remove(taskId),
        remainingTasks: state.remainingTasks.remove(taskId),
        tasks: state.tasks.remove(taskId),
      ),
    );
  }

  Future<void> _load() async {
    final tasks = await _tasksRepository.getAll();
    final todayReportages = await _reportageRepository.getTodayReportages();

    final newState = _separateCompletedAndRemainingTasks(
      tasks,
      todayReportages,
    );
    emit(newState);
  }

  TasksState _separateCompletedAndRemainingTasks(
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

    return state.copyWith(
      isLoading: false,
      completedTasks: state.completedTasks.init(completedTasks),
      remainingTasks: state.remainingTasks.init(remainingTasks),
      tasks: state.tasks.init(tasks),
    );
  }

  void addTask(Task task) {
    emit(
      state.copyWith(
        tasks: state.tasks.add(task),
        remainingTasks: state.remainingTasks.add(task),
      ),
    );
  }

  void updateTask(Task task) {
    emit(
      state.copyWith(
        completedTasks: state.completedTasks.update(task),
        remainingTasks: state.remainingTasks.update(task),
        tasks: state.tasks.update(task),
      ),
    );
  }

  void _onTaskAddedEvent(TaskAddedEvent event) {
    addTask(event.task);
  }

  void _onTaskEditedEvent(TaskEditedEvent event) {
    updateTask(event.task);
  }
}
