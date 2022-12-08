import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/models/pomodoro_task_reportage_model.dart';
import 'package:pomotimer/utils/utils.dart';

class TasksReportageDatabase {
  late LazyBox _tasksBox;

  Future<void> init() async {
    _tasksBox = await Hive.openLazyBox('tasks_reportage');
  }

  int get tasksLength => _tasksBox.length;

  void listen(void Function() listener) {
    _tasksBox.listenable().addListener(listener);
  }

  Future<Either<Exception, List<PomodoroTaskReportageModel>>> getTasks(int begin, int end) async {
    try {
      final List<PomodoroTaskReportageModel> result = [];
      final listOfKeys = _tasksBox.keys.toList();
      final selectedKeys = listOfKeys.sublist(begin, end);
      for (int key in selectedKeys) {
        final Map<dynamic, dynamic> data = await _tasksBox.get(key);
        final task = PomodoroTaskReportageModel.fromMap(data);
        result.add(task.copyWith(id: key));
      }
      return Right(result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, List<PomodoroTaskReportageModel>>> getAllReportagesInDate(
      DateTime date) async {
    try {
      final List<PomodoroTaskReportageModel> result = [];
      for (int i = _tasksBox.keys.length - 1; i >= 0; i--) {
        final key = _tasksBox.keys.elementAt(i);
        final Map<dynamic, dynamic> data = await _tasksBox.get(key);
        PomodoroTaskReportageModel task = PomodoroTaskReportageModel.fromMap(data);
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

  Future<Either<Exception, PomodoroTaskReportageModel>> getByIndex(int index) async {
    try {
      final key = _tasksBox.keys.elementAt(index);
      final data = await _tasksBox.get(key);
      final task = PomodoroTaskReportageModel.fromMap(data);
      return Right(task.copyWith(id: key));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, int?>> indexWhere(
    bool Function(PomodoroTaskReportageModel t) test,
  ) async {
    try {
      for (int i = _tasksBox.keys.length - 1; i >= 0; i--) {
        final key = _tasksBox.keys.elementAt(i);
        final Map<dynamic, dynamic> data = await _tasksBox.get(key);
        PomodoroTaskReportageModel task = PomodoroTaskReportageModel.fromMap(data);
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

  Future<Either<Exception, PomodoroTaskReportageModel>> add(PomodoroTaskReportageModel task) async {
    try {
      int id = await _tasksBox.add(task.toMap());
      return Right(task.copyWith(id: id));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, void>> update(PomodoroTaskModel pomodoroTaskModel) async {
    try {
      for (var key in _tasksBox.keys) {
        final map = await _tasksBox.get(key);
        final PomodoroTaskReportageModel reportageTask = PomodoroTaskReportageModel.fromMap(map);
        if (reportageTask.pomodoroTaskId == pomodoroTaskModel.id!) {
          _tasksBox.put(
            key,
            reportageTask
                .copyWith(
                  taskName: pomodoroTaskModel.title,
                )
                .toMap(),
          );
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, void>> delete(int pomodoroTaskId) async {
    try {
      for (var key in _tasksBox.keys) {
        final map = await _tasksBox.get(key);
        final PomodoroTaskReportageModel task = PomodoroTaskReportageModel.fromMap(map);
        if (task.pomodoroTaskId == pomodoroTaskId) {
          _tasksBox.delete(key);
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
