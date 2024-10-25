import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:sptimer/data/models/pomodoro_task_reportage.dart';
import 'package:sptimer/utils/utils.dart';

import 'tasks_reportage_list_view_state.dart';

class TasksReportageListViewController extends GetxController {
  late final taskWidgetsHeight = 110.h;
  late final separatedWidgetsHeight = 50.h;
  late final _approximation = 300.h;
  late final FlutterListViewController scrollController;

  late List<PomodoroTaskReportage> _tasks;
  late List<_SeparatedWidgetInfo> _separatedWidgetsInfo;
  late FlutterListViewItemPosition _currentItemPosition;

  double _offset = 0.0;
  bool _isAnimating = false;
  TasksReportageListViewState _state = TasksReportageListViewState.initialLoading;
  void Function(DateTime newDate)? onScrollDateChanged;
  bool Function(bool isAtTop)? onScrollEnd;

  List<PomodoroTaskReportage> get tasks => _tasks;
  TasksReportageListViewState get state => _state;
  int get itemCount => tasks.length * 2 - 1;

  @override
  void onInit() {
    scrollController = FlutterListViewController();
    scrollController.sliverController.onPaintItemPositionsCallback = (_, positions) {
      _currentItemPosition = positions.first;
    };
    scrollController.addListener(_onScroll);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void init({
    required List<PomodoroTaskReportage> tasks,
  }) {
    _tasks = tasks;
    _separatedWidgetsInfo = [];
    for (var i = 0; i < _tasks.length * 2 - 1; i++) {
      int itemIndex = i ~/ 2;
      if (i.isEven) continue;
      if (checkIsDateChanged(itemIndex + 1)) {
        _separatedWidgetsInfo.add(
          _SeparatedWidgetInfo(index: i, dateTime: _tasks[itemIndex + 1].startDate),
        );
      }
    }
    setState(
      TasksReportageListViewState.loaded,
    );
  }

  void updateTasks({
    required List<PomodoroTaskReportage> newTasks,
    PomodoroTaskReportage? visibleTask,
  }) {
    int newIndex;
    final itemIndex = _currentItemPosition.index ~/ 2;
    final item = visibleTask ?? _tasks[itemIndex];
    newIndex = newTasks.indexWhere((e) => e.id == item.id);
    newIndex *= 2;
    if (visibleTask != null && _currentItemPosition.index.isOdd) {
      newIndex++;
    }
    init(tasks: newTasks);
    final offset = visibleTask != null ? separatedWidgetsHeight : _currentItemPosition.offset;
    scrollController.sliverController.jumpToIndex(
      newIndex,
      offset: offset,
    );
  }

  void setState(TasksReportageListViewState newState) {
    if (_state == newState) return;
    _state = newState;
    update();
  }

  bool checkIsDateChanged(int index) {
    if (index == 0) return false;
    final task = _tasks[index];
    final previousTask = _tasks[index - 1];
    if (previousTask.startDate.isInSameDay(task.startDate)) {
      return false;
    }

    return true;
  }

  Future<bool> animateToDate(DateTime date) async {
    if (_tasks.isEmpty) return false;
    _isAnimating = true;
    int index;
    if (_tasks.first.startDate.isInSameDay(date)) {
      index = 0;
    } else {
      final separatedWidgetInfo = _separatedWidgetsInfo.firstWhereOrNull(
        (e) => e.dateTime.isInSameDay(date),
      );
      if (separatedWidgetInfo == null) {
        _isAnimating = false;
        return false;
      }
      index = separatedWidgetInfo.index;
    }
    await scrollController.sliverController.animateToIndex(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
    _isAnimating = false;
    _offset = scrollController.offset;
    return true;
  }

  void _onScroll() {
    if (_isAnimating) return;
    _onScrollAtEdge();
    if (_currentItemPosition.index == 0) {
      onScrollDateChanged?.call(tasks.first.startDate.roundToDay);
    } else if (scrollController.offset == scrollController.position.maxScrollExtent) {
      onScrollDateChanged?.call(tasks.last.startDate.roundToDay);
    }
    final separatedWidgetInfo =
        _separatedWidgetsInfo.firstWhereOrNull((e) => e.index == _currentItemPosition.index);
    if (separatedWidgetInfo != null) {
      onScrollDateChanged?.call(separatedWidgetInfo.dateTime.roundToDay);
    }
  }

  void _onScrollAtEdge() {
    final isBottom =
        scrollController.offset >= scrollController.position.maxScrollExtent - _approximation;
    final isTop = scrollController.offset.isAroundOf(0.0, _approximation);
    final offsetDifference = _offset - scrollController.offset;
    final isScrollingToTop = offsetDifference >= 0;
    if (isBottom && isScrollingToTop == false) {
      final hasMoreItem = onScrollEnd?.call(false);
      if (hasMoreItem ?? false) {
        setState(TasksReportageListViewState.loadingAtBottom);
      }
    } else if (isTop && isScrollingToTop) {
      final hasMoreItem = onScrollEnd?.call(true);
      if (hasMoreItem ?? false) {
        setState(TasksReportageListViewState.loadingAtTop);
      }
    }
    _offset = scrollController.offset;
  }
}

class _SeparatedWidgetInfo {
  _SeparatedWidgetInfo({
    required this.index,
    required this.dateTime,
  });

  final int index;
  final DateTime dateTime;
}
