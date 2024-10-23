import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sptimer/data/models/pomodoro_task.dart';
import 'package:sptimer/data/models/pomodoro_task_reportage.dart';
import 'package:sptimer/utils/utils.dart';

class TasksReportageDatabase {
  late LazyBox _tasksBox;
  final _onChangesNotifier = StreamController.broadcast();

  Future<void> init() async {
    _tasksBox = await Hive.openLazyBox('tasks_reportage');
  }

  int get tasksLength => _tasksBox.length;

  void listen(void Function() listener) {
    _onChangesNotifier.stream.listen((_) => listener());
  }

  Future<Either<Exception, List<PomodoroTaskReportage>>> getTasks(int begin, int end) async {
    try {
      final List<PomodoroTaskReportage> result = [];
      final listOfKeys = _tasksBox.keys.toList();
      final selectedKeys = listOfKeys.sublist(begin, end);
      for (int key in selectedKeys) {
        final Map<dynamic, dynamic> data = await _tasksBox.get(key);
        final task = PomodoroTaskReportage.fromMap(data);
        result.add(task.copyWith(id: key));
      }
      return Right(result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, List<PomodoroTaskReportage>>> getAllReportagesInDate(
      DateTime date) async {
    try {
      final List<PomodoroTaskReportage> result = [];
      for (int i = _tasksBox.keys.length - 1; i >= 0; i--) {
        final key = _tasksBox.keys.elementAt(i);
        final Map<dynamic, dynamic> data = await _tasksBox.get(key);
        PomodoroTaskReportage task = PomodoroTaskReportage.fromMap(data);
        task = task.copyWith(id: key);
        if (task.startDate.isInSameDay(date)) {
          result.add(task);
        } else if (task.startDate.isBefore(date)) {
          break;
        }
      }
      return Right(result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, PomodoroTaskReportage>> getByIndex(int index) async {
    try {
      final key = _tasksBox.keys.elementAt(index);
      final data = await _tasksBox.get(key);
      final task = PomodoroTaskReportage.fromMap(data);
      return Right(task.copyWith(id: key));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, int?>> indexWhere(
    bool Function(PomodoroTaskReportage t) test,
  ) async {
    try {
      for (int i = _tasksBox.keys.length - 1; i >= 0; i--) {
        final key = _tasksBox.keys.elementAt(i);
        final Map<dynamic, dynamic> data = await _tasksBox.get(key);
        PomodoroTaskReportage task = PomodoroTaskReportage.fromMap(data);
        task = task.copyWith(id: key);
        if (test(task)) {
          return Right(i);
        }
      }
      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, PomodoroTaskReportage>> add(PomodoroTaskReportage task) async {
    try {
      int id = await _tasksBox.add(task.toMap());
      _onChangesNotifier.add(null);
      return Right(task.copyWith(id: id));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, void>> update(PomodoroTask pomodoroTaskModel) async {
    try {
      for (var key in _tasksBox.keys) {
        final map = await _tasksBox.get(key);
        final PomodoroTaskReportage reportageTask = PomodoroTaskReportage.fromMap(map);
        if (reportageTask.pomodoroTaskId == pomodoroTaskModel.id!) {
          await _tasksBox.put(
            key,
            reportageTask.copyWith(taskName: pomodoroTaskModel.title).toMap(),
          );
        }
      }
      _onChangesNotifier.add(null);

      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, void>> delete(int pomodoroTaskId) async {
    try {
      for (var key in _tasksBox.keys) {
        final map = await _tasksBox.get(key);
        final PomodoroTaskReportage task = PomodoroTaskReportage.fromMap(map);
        if (task.pomodoroTaskId == pomodoroTaskId) {
          await _tasksBox.delete(key);
        }
      }
      _onChangesNotifier.add(null);

      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
