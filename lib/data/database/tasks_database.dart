import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomotimer/data/models/pomodoro_model.dart';

class TasksDatabase {
  late final Box _tasks;

  Future<void> init() async {
    _tasks = await Hive.openBox('tasks');
  }

  Future<Either<Exception, List<PomodoroTaskModel>>> getAll() async {
    try {
      final List<PomodoroTaskModel> result = [];
      for (var i = 0; i < _tasks.length; i++) {
        final Map<dynamic, dynamic> data = _tasks.get(i);
        final task = PomodoroTaskModel.fromMap(data);
        result.add(task);
      }
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, int>> add(PomodoroTaskModel task) async {
    try {
      task.id = _tasks.length;
      await _tasks.put(_tasks.length, task.toMap());
      return Right(_tasks.length);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, void>> update(PomodoroTaskModel task) async {
    try {
      await _tasks.put(task.id, task.toMap());
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, void>> delete(int id) async {
    try {
      await _tasks.delete(id);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
