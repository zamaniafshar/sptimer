import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:pomotimer/data/databases/tasks_reportage_database.dart';
import 'package:pomotimer/data/models/pomodoro_task_reportage_model.dart';
import 'package:pomotimer/ui/screens/calendar/event_notifier_enum.dart';
import 'package:pomotimer/ui/screens/calendar/widgets/custom_date_picker/custom_date_picker_controller.dart';
import 'package:pomotimer/ui/screens/calendar/widgets/tasks_reportage_list_view/tasks_reportage_list_view_state.dart';
import 'package:pomotimer/utils/utils.dart';

import 'widgets/tasks_reportage_list_view/tasks_reportage_list_view_controller.dart';

const _numberOfItems = 50;

class CalendarScreenController extends GetxController {
  late final CustomDatePickerController _datePickerController;
  late final TasksReportageListViewController _tasksReportageListViewController;
  late final TasksReportageDatabase _tasksReportageDatabase;
  late final StreamController<CalendarScreenEvent> _screenNotifierController;

  bool _inProgress = false;
  late int _beginIndex;
  late int _endIndex;

  Stream<CalendarScreenEvent> get screenNotifier => _screenNotifierController.stream;

  bool get _hasMoreItemFromTop => _endIndex < _tasksReportageDatabase.tasksLength;
  bool get _hasMoreItemFromBottom => _beginIndex > 0;

  @override
  void onInit() async {
    _datePickerController = Get.put(CustomDatePickerController());
    _tasksReportageListViewController = Get.put(TasksReportageListViewController());
    _tasksReportageDatabase = Get.find<TasksReportageDatabase>();
    _screenNotifierController = StreamController();
    _tasksReportageDatabase.listen(init);
    init();
    _tasksReportageListViewController.onScrollDateChanged = _onScrollDateChanged;
    _tasksReportageListViewController.onScrollEnd = _onScrollEnd;
    _datePickerController.onSelectedDateChanged = _onSelectedDayChanged;
    super.onInit();
  }

  @override
  void onClose() {
    Get.delete<CustomDatePickerController>();
    Get.delete<TasksReportageListViewController>();
    super.onClose();
  }

  Future<void> init() async {
    _tasksReportageListViewController.setState(TasksReportageListViewState.initialLoading);
    _datePickerController.init(DateTime.now());
    _endIndex = _tasksReportageDatabase.tasksLength;
    _beginIndex = min(0, _endIndex - _numberOfItems * 2);
    final tasks = await _readTasks();
    if (tasks == null) return;
    _tasksReportageListViewController.init(
      tasks: tasks,
    );

    if (tasks.isNotEmpty) {
      _datePickerController.init(tasks.first.startDate);
    }
  }

  Future<List<PomodoroTaskReportageModel>?> _loadMoreFromTop() async {
    _beginIndex = _beginIndex + _numberOfItems;
    _endIndex = _endIndex + _numberOfItems;

    if (_endIndex > _tasksReportageDatabase.tasksLength) {
      _beginIndex = _tasksReportageDatabase.tasksLength - _numberOfItems * 2;
    }
    return _readTasks();
  }

  Future<List<PomodoroTaskReportageModel>?> _loadMoreFromBottom() async {
    _endIndex = _endIndex - _numberOfItems;
    _beginIndex = _beginIndex - _numberOfItems;
    if (_beginIndex < 0) {
      _endIndex = _numberOfItems * 2;
    }

    return _readTasks();
  }

  Future<List<PomodoroTaskReportageModel>?> _readTasks() async {
    if (_endIndex > _tasksReportageDatabase.tasksLength) {
      _endIndex = _tasksReportageDatabase.tasksLength;
    }
    if (_beginIndex < 0) {
      _beginIndex = 0;
    }
    final result = await _tasksReportageDatabase.getTasks(_beginIndex, _endIndex);
    return result.fold(
      (l) {
        _tasksReportageListViewController.setState(TasksReportageListViewState.error);
        return null;
      },
      (r) => r.reversed.toList(),
    );
  }

  void _onScrollDateChanged(DateTime date) {
    _datePickerController.selectedDate = date;
  }

  bool _onScrollEnd(bool isAtTop) {
    if (_hasMoreItemFromTop && isAtTop || _hasMoreItemFromBottom && isAtTop == false) {
      _loadMoreTasks(isAtTop);
      return true;
    }
    return false;
  }

  Future<void> _loadMoreTasks(bool isAtTop) async {
    if (_inProgress) return;
    _inProgress = true;
    List<PomodoroTaskReportageModel>? tasks;

    tasks = isAtTop ? await _loadMoreFromTop() : await _loadMoreFromBottom();
    if (tasks == null) return;
    _tasksReportageListViewController.updateTasks(
      newTasks: tasks,
    );
    _inProgress = false;
  }

  void _onSelectedDayChanged(DateTime date) async {
    bool isExistInList = await _tasksReportageListViewController.animateToDate(date);
    if (isExistInList) return;
    final result = await _tasksReportageDatabase.indexWhere(
      (t) => t.startDate.isInSameDay(date),
    );

    result.fold(
      (l) => _screenNotifierController.add(CalendarScreenEvent.error),
      (index) async {
        if (index == null) {
          return _screenNotifierController.add(CalendarScreenEvent.taskNotFound);
        }
        _tasksReportageListViewController.setState(TasksReportageListViewState.loadingAtCenter);
        _beginIndex = index - _numberOfItems;
        _endIndex = index + _numberOfItems;
        final task = (await _tasksReportageDatabase.getByIndex(index)).fold(
          (l) => null,
          (r) => r,
        );
        final tasks = await _readTasks();
        if (tasks == null || task == null) {
          return _screenNotifierController.add(CalendarScreenEvent.error);
        }
        _tasksReportageListViewController.updateTasks(
          newTasks: tasks,
          visibleTask: task,
        );
      },
    );
  }
}
