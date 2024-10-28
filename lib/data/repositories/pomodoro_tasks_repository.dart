import 'package:sptimer/data/models/pomodoro_task.dart';
import 'package:sptimer/utils/database.dart';
import 'package:sptimer/utils/result.dart';

final class PomodoroTasksRepository {
  PomodoroTasksRepository(this._database);

  final Database _database;

  Future<Result<List<PomodoroTask>, Exception>> getAll() async {
    return Result.tryCatch(() async {
      final tasks = <PomodoroTask>[];
      for (int key in _database.keys) {
        final data = await _database.get(key);
        final task = PomodoroTask.fromMap(data);
        tasks.add(task);
      }
      return tasks;
    });
  }

  Future<Result<void, Exception>> add(PomodoroTask task) async {
    return Result.tryCatch(() async {
      await _database.save(task.id, task.toMap());
    });
  }

  Future<Result<void, Exception>> update(PomodoroTask task) async {
    return Result.tryCatch(() async {
      await _database.update(task.id, task.toMap());
    });
  }

  Future<Result<void, Exception>> delete(String id) async {
    return Result.tryCatch(() async {
      await _database.delete(id);
    });
  }
}
