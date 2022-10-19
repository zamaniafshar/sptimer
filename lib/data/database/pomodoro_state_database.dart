import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';

class PomodoroStateDatabase {
  late final Box _stateBox;

  Future<void> init() async {
    _stateBox = await Hive.openBox('pomodoro_state');
  }

  Future<Either<Exception, PomodoroTaskModel?>> getState() async {
    try {
      final map = _stateBox.get('state');
      final state = map != null ? PomodoroTaskModel.fromMap(map) : null;
      return Right(state);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, bool>> save(PomodoroTaskModel task) async {
    try {
      _stateBox.put('state', task.toMap());
      return const Right(true);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, bool>> clear() async {
    try {
      _stateBox.clear();
      return const Right(true);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
