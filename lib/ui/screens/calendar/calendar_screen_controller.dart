import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:sptimer/controller/app_settings_controller.dart';
import 'package:sptimer/data/databases/tasks_reportage_database.dart';
import 'package:sptimer/data/models/pomodoro_task_reportage_model.dart';
import 'package:sptimer/ui/screens/calendar/event_notifier_enum.dart';
import 'package:sptimer/ui/screens/calendar/widgets/custom_date_picker/custom_date_picker_controller.dart';
import 'package:sptimer/ui/screens/calendar/widgets/tasks_reportage_list_view/tasks_reportage_list_view_state.dart';
import 'package:sptimer/utils/utils.dart';

import 'widgets/tasks_reportage_list_view/tasks_reportage_list_view_controller.dart';

const _numberOfItems = 50;

class CalendarScreenController extends GetxController {
  late final TasksReportageListViewController _tasksReportageListViewController;
  late final TasksReportageDatabase _tasksReportageDatabase;
  late final StreamController<CalendarScreenEvent> _screenNotifierController;

  CustomDatePickerController? _datePickerController;
  late int _beginIndex;
  late int _endIndex;
  bool _inProgress = false;

  Stream<CalendarScreenEvent> get screenNotifier => _screenNotifierController.stream;
  CustomDatePickerController get datePickerController => _datePickerController!;
  bool get _hasMoreItemFromTop => _endIndex < _tasksReportageDatabase.tasksLength;
  bool get _hasMoreItemFromBottom => _beginIndex > 0;

  @override
  void onInit() async {
    _tasksReportageListViewController = Get.put(TasksReportageListViewController());
    _tasksReportageDatabase = Get.find<TasksReportageDatabase>();
    _initDatePickerController();
    Get.find<AppSettingsController>().addListener(() {
      _initDatePickerController();
    });
    _screenNotifierController = StreamController();
    _tasksReportageDatabase.listen(init);
    init();
    _tasksReportageListViewController.onScrollDateChanged = _onScrollDateChanged;
    _tasksReportageListViewController.onScrollEnd = _onScrollEnd;
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

    datePickerController.init(DateTime.now());
    _endIndex = _tasksReportageDatabase.tasksLength;
    _beginIndex = min(0, _endIndex - _numberOfItems * 2);
    final tasks = await _readTasks();
    if (tasks == null) return;
    _tasksReportageListViewController.init(
      tasks: tasks,
    );

    if (tasks.isNotEmpty) {
      datePickerController.init(tasks.first.startDate);
    }
  }

  void _initDatePickerController() {
    final datePickerType = Get.find<AppSettingsController>().isEnglish
        ? DatePickerType.english
        : DatePickerType.persian;
    final date = _datePickerController?.selectedDateTime;
    _datePickerController = CustomDatePickerController(datePickerType: datePickerType);

    _datePickerController!.init(date ?? DateTime.now());
    datePickerController.onSelectedDateChanged = _onSelectedDayChanged;
    update();
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
    datePickerController.selectedDateTime = date;
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
