import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';

class TasksDatabase {
  late final Box _tasks;

  Future<void> init() async {
    _tasks = await Hive.openBox('tasks');
  }

  Future<Either<Exception, List<PomodoroTaskModel>>> getAll() async {
    try {
      final List<PomodoroTaskModel> result = [];
      for (int key in _tasks.keys) {
        final Map<dynamic, dynamic>? data = _tasks.get(key);
        if (data == null) continue;
        final task = PomodoroTaskModel.fromMap(data);
        result.add(task.copyWith(id: key));
      }
      return Right(result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, PomodoroTaskModel>> add(PomodoroTaskModel task) async {
    try {
      int id = await _tasks.add(task.toMap());
      return Right(task.copyWith(id: id));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, void>> update(PomodoroTaskModel task) async {
    try {
      await _tasks.put(task.id, task.toMap());
      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, void>> delete(int id) async {
    try {
      await _tasks.delete(id);
      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
