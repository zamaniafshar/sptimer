import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sptimer/data/databases/tasks_database.dart';
import 'package:sptimer/data/databases/tasks_reportage_database.dart';
import 'package:sptimer/data/models/pomodoro_task_model.dart';
import 'package:sptimer/ui/screens/tasks/tasks_list_status.dart';
import 'package:sptimer/ui/screens/tasks/widgets/task_info_widget.dart';

class TasksController extends GetxController {
  final TasksDatabase _database = TasksDatabase();
  final TasksReportageDatabase _tasksReportageDatabase = Get.find();
  final _allTasks = <PomodoroTaskModel>[].obs;
  final _doneTasks = <PomodoroTaskModel>[].obs;
  final _remainedTasks = <PomodoroTaskModel>[].obs;
  final _allTasksListKey = GlobalKey<AnimatedListState>();
  GlobalKey<AnimatedListState> _doneTasksListKey = GlobalKey<AnimatedListState>();
  GlobalKey<AnimatedListState> _remainedTasksListKey = GlobalKey<AnimatedListState>();

  final _allTasksListStatus = TasksListStatus.loading.obs;
  final _doneTasksListStatus = TasksListStatus.loading.obs;
  final _remainedTasksListStatus = TasksListStatus.loading.obs;
  final _isAnimatingInitialValues = true.obs;

  List<PomodoroTaskModel> get allTasks => _allTasks;
  List<PomodoroTaskModel> get doneTasks => _doneTasks;
  List<PomodoroTaskModel> get remainedTasks => _remainedTasks;
  GlobalKey<AnimatedListState> get allTasksListKey => _allTasksListKey;
  GlobalKey<AnimatedListState> get doneTasksListKey => _doneTasksListKey;
  GlobalKey<AnimatedListState> get remainedTasksListKey => _remainedTasksListKey;
  TasksListStatus get allTasksListStatus => _allTasksListStatus.value;
  TasksListStatus get doneTasksListStatus => _doneTasksListStatus.value;
  TasksListStatus get remainedTasksListStatus => _remainedTasksListStatus.value;
  bool get isAnimatingInitialValues => _isAnimatingInitialValues.value;

  @override
  void onInit() {
    _tasksReportageDatabase.listen(() {
      _initDoneAndRemainedTasks(_allTasks);
    });
    init();
    super.onInit();
  }

  Future<void> init() async {
    await _database.init();
    final result = await _database.getAll();
    result.fold(
      (l) {
        _markAllAsError();
      },
      (r) {
        r = r.reversed.toList();
        _allTasksListStatus.value = TasksListStatus.loaded;
        _insertAllWithAnimation(r);

        _initDoneAndRemainedTasks(r);
      },
    );
  }

  void _markAllAsError() {
    _allTasksListStatus.value = TasksListStatus.error;
    _doneTasksListStatus.value = TasksListStatus.error;
    _remainedTasksListStatus.value = TasksListStatus.error;
  }

  Future<void> _insertAllWithAnimation(List<PomodoroTaskModel> newTasks) async {
    for (var i = 0; i < newTasks.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      _allTasksListKey.currentState?.insertItem(
        i,
        duration: const Duration(milliseconds: 500),
      );

      _allTasks.add(newTasks[i]);
    }
    _isAnimatingInitialValues.value = false;
  }

  Future<void> _initDoneAndRemainedTasks(List<PomodoroTaskModel> newTasks) async {
    _doneTasksListStatus.value = TasksListStatus.loading;
    _remainedTasksListStatus.value = TasksListStatus.loaded;
    final now = DateTime.now();
    final result = await _tasksReportageDatabase.getAllReportagesInDate(now);
    _doneTasksListKey = GlobalKey<AnimatedListState>();
    _remainedTasksListKey = GlobalKey<AnimatedListState>();
    _doneTasks.clear();
    _remainedTasks.clear();

    result.fold(
      (l) {
        _markAllAsError();
      },
      (r) {
        final reports = r;
        for (PomodoroTaskModel task in newTasks) {
          final isDone = reports.any((element) => element.pomodoroTaskId == task.id);
          if (isDone) {
            _doneTasks.add(task);
          } else {
            _remainedTasks.add(task);
          }
        }
        _doneTasksListStatus.value = TasksListStatus.loaded;
        _remainedTasksListStatus.value = TasksListStatus.loaded;
      },
    );
  }

  Future<void> addTask(PomodoroTaskModel task) async {
    final result = await _database.add(task);
    result.fold(
      (l) {
        _markAllAsError();
      },
      (r) async {
        await Future.delayed(const Duration(milliseconds: 500));
        _allTasksListKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 500));
        _remainedTasksListKey.currentState
            ?.insertItem(0, duration: const Duration(milliseconds: 500));
        _allTasks.insert(0, r);
        _remainedTasks.insert(0, r);
      },
    );
  }

  Future<void> updateTask(PomodoroTaskModel task) async {
    final result = await _database.update(task);

    result.fold(
      (l) {
        _markAllAsError();
      },
      (r) async {
        final indexInAllTask = _allTasks.indexWhere((e) => e.id == task.id);
        _allTasks[indexInAllTask] = task;

        final indexInDoneTasks = _doneTasks.indexWhere((e) => e.id == task.id);
        if (indexInDoneTasks != -1) _doneTasks[indexInDoneTasks] = task;

        final indexInRemainTasks = _remainedTasks.indexWhere((e) => e.id == task.id);
        if (indexInRemainTasks != -1) _remainedTasks[indexInRemainTasks] = task;
        await _tasksReportageDatabase.update(task);
      },
    );
  }

  void _removeItemWithAnimation(
    GlobalKey<AnimatedListState> key,
    List<PomodoroTaskModel> list,
    int index,
  ) {
    final task = list[index];
    key.currentState?.removeItem(
      index,
      (context, animation) => TaskInfoWidget(task: task, animation: animation),
      duration: const Duration(milliseconds: 500),
    );
    list.removeAt(index);
  }

  Future<void> deleteTask(int id) async {
    final result = await _database.delete(id);

    result.fold(
      (l) {
        _markAllAsError();
      },
      (r) async {
        final indexInAllTasks = _allTasks.indexWhere((e) => e.id == id);
        _removeItemWithAnimation(_allTasksListKey, _allTasks, indexInAllTasks);

        final indexInDoneTasks = _doneTasks.indexWhere((e) => e.id == id);
        if (indexInDoneTasks != -1) {
          _removeItemWithAnimation(_doneTasksListKey, _doneTasks, indexInDoneTasks);
        }

        final indexInRemainTasks = _remainedTasks.indexWhere((e) => e.id == id);
        if (indexInRemainTasks != -1) {
          _removeItemWithAnimation(_remainedTasksListKey, _remainedTasks, indexInRemainTasks);
        }
        await _tasksReportageDatabase.delete(id);
      },
    );
  }
}
