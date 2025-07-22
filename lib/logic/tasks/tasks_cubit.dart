import 'package:bloc/bloc.dart';
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
  })  : _tasksRepository = tasksRepository,
        _reportageRepository = reportageRepository,
        super(TasksState.initial()) {
    _load();

    onEach(EventsBus.on<TaskAddedEvent>(), onData: _onTaskAddedEvent);
    onEach(EventsBus.on<TaskEditedEvent>(), onData: _onTaskEditedEvent);
  }

  final TasksRepository _tasksRepository;
  final TasksReportageRepository _reportageRepository;

  Future<void> delete(String taskId) async {
    await _tasksRepository.delete(taskId);
    await _reportageRepository.deleteTaskReportages(taskId);

    final tasks = List.of(state.tasks);
    final remainingTasks = List.of(state.remainingTasks);
    final completedTasks = List.of(state.completedTasks);

    tasks.removeWhere((value) => value.id == taskId);
    remainingTasks.removeWhere((value) => value.id == taskId);
    completedTasks.removeWhere((value) => value.id == taskId);

    emit(
      state.copyWith(
        completedTasks: completedTasks,
        remainingTasks: remainingTasks,
        tasks: tasks,
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

    return TasksState(
      isLoading: false,
      tasks: tasks,
      remainingTasks: completedTasks,
      completedTasks: remainingTasks,
    );
  }

  void addTask(Task task) {
    final tasks = List.of(state.tasks);
    final remainingTasks = List.of(state.remainingTasks);

    tasks.add(task);
    remainingTasks.add(task);

    emit(
      state.copyWith(
        tasks: tasks,
        remainingTasks: remainingTasks,
      ),
    );
  }

  void updateTask(Task task) {
    final tasks = List.of(state.tasks);
    final remainingTasks = List.of(state.remainingTasks);
    final completedTasks = List.of(state.completedTasks);

    tasks.updateById(task);
    remainingTasks.updateById(task);
    completedTasks.updateById(task);

    emit(
      state.copyWith(
        tasks: tasks,
        remainingTasks: remainingTasks,
        completedTasks: completedTasks,
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
