import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomotimer/data/models/pomodoro_app_state_data.dart';

const _stateKey = 'state';

class PomodoroStateDatabase {
  late Box _stateBox;

  Future<void> init() async {
    _stateBox = await Hive.openBox('pomodoro_state');
  }

  Future<Either<Exception, PomodoroAppSateData?>> getState() async {
    try {
      final map = _stateBox.get(_stateKey);
      final state = map != null ? PomodoroAppSateData.fromMap(map) : null;
      return Right(state);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, bool>> save(PomodoroAppSateData state) async {
    try {
      await _stateBox.put(_stateKey, state.toMap());
      return const Right(true);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, bool>> clear() async {
    try {
      await _stateBox.clear();
      return const Right(true);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
