import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/common/database.dart';

final class TasksRepository {
  TasksRepository(this._database);

  final Database _database;

  Future<List<Task>> getAll() async {
    final tasks = <Task>[];
    for (final future in _database.getAll()) {
      final data = await future;
      final task = Task.fromJson(data);
      tasks.add(task);
    }
    return tasks;
  }

  Future<void> add(Task task) async {
    await _database.save(task.id, task.toJson());
  }

  Future<void> update(Task task) async {
    await _database.save(task.id, task.toJson());
  }

  Future<void> delete(String id) async {
    await _database.delete(id);
  }
}
