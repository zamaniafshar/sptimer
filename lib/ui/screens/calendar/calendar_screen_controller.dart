import 'dart:async';
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
  late int beginIndex;
  late int endIndex;

  Stream<CalendarScreenEvent> get screenNotifier => _screenNotifierController.stream;

  bool get _hasMoreItemFromTop => endIndex < _tasksReportageDatabase.tasksLength;
  bool get _hasMoreItemFromBottom => beginIndex > 0;

  @override
  void onInit() async {
    _datePickerController = Get.put(CustomDatePickerController());
    _tasksReportageListViewController = Get.put(TasksReportageListViewController());
    _tasksReportageDatabase = Get.find<TasksReportageDatabase>();
    _screenNotifierController = StreamController();
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
    _datePickerController.init(DateTime.now());
    endIndex = _tasksReportageDatabase.tasksLength;
    beginIndex = endIndex - _numberOfItems * 2;
    final tasks = await _readTasks();
    if (tasks == null) return;
    _tasksReportageListViewController.init(
      tasks: tasks,
    );

    if (tasks.isNotEmpty) {
      _datePickerController.init(tasks.first.startDate);
    }
  }

  Future<List<PomodoroTaskReportageModel>?> _readTasks() async {
    if (endIndex > _tasksReportageDatabase.tasksLength) {
      endIndex = _tasksReportageDatabase.tasksLength;
      beginIndex = endIndex - _numberOfItems * 2;
    }
    if (beginIndex < 0) {
      beginIndex = 0;
      endIndex = _numberOfItems * 2;
    }
    final result = await _tasksReportageDatabase.getTasks(beginIndex, endIndex);
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
      _loadMore(isAtTop);
      return true;
    }
    return false;
  }

  Future<void> _loadMore(bool isAtTop) async {
    if (_inProgress) return;
    _inProgress = true;
    List<PomodoroTaskReportageModel>? tasks;

    if (isAtTop) {
      beginIndex = beginIndex + _numberOfItems;
      endIndex = endIndex + _numberOfItems;
    } else {
      endIndex = endIndex - _numberOfItems;
      beginIndex = beginIndex - _numberOfItems;
    }
    tasks = await _readTasks();
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
        beginIndex = index - _numberOfItems;
        endIndex = index + _numberOfItems;
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
