import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomotimer/data/models/pomodoro_task_reportage_model.dart';

class TasksReportageDatabase {
  late final LazyBox _tasksBox;

  Future<void> init() async {
    _tasksBox = await Hive.openLazyBox('tasks_reportage');
  }

  int get tasksLength => _tasksBox.length;

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

  Future<Either<Exception, void>> delete(int pomodoroTaskId) async {
    try {
      for (var key in _tasksBox.keys.toList().reversed) {
        final PomodoroTaskReportageModel task = await _tasksBox.get(key);
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
