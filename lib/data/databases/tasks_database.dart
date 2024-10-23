import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sptimer/data/models/pomodoro_task.dart';

class TasksDatabase {
  late final Box _tasksBox;

  Future<void> init() async {
    _tasksBox = await Hive.openBox('tasks');
  }

  Future<Either<Exception, List<PomodoroTask>>> getAll() async {
    try {
      final List<PomodoroTask> result = [];
      for (int key in _tasksBox.keys) {
        final Map<dynamic, dynamic>? data = _tasksBox.get(key);
        if (data == null) continue;
        final task = PomodoroTask.fromMap(data);
        result.add(task.copyWith(id: key));
      }
      return Right(result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, PomodoroTask>> add(PomodoroTask task) async {
    try {
      int id = await _tasksBox.add(task.toMap());
      return Right(task.copyWith(id: id));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, void>> update(PomodoroTask task) async {
    try {
      await _tasksBox.put(task.id!, task.toMap());
      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, void>> delete(int id) async {
    try {
      await _tasksBox.delete(id);
      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
