import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/utils/database.dart';
import 'package:sptimer/utils/result.dart';

final class TasksRepository {
  TasksRepository(this._database);

  final Database _database;

  Future<Result<List<Task>, Exception>> getAll() async {
    return Result.tryCatch(() async {
      final tasks = <Task>[];
      for (int key in _database.keys) {
        final data = await _database.get(key);
        final task = Task.fromMap(data);
        tasks.add(task);
      }
      return tasks;
    });
  }

  Future<Result<void, Exception>> add(Task task) async {
    return Result.tryCatch(() async {
      await _database.save(task.id, task.toMap());
    });
  }

  Future<Result<void, Exception>> update(Task task) async {
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
