import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/common/database.dart';
import 'package:sptimer/common/result.dart';
import 'package:sptimer/common/streamable_changes.dart';

final class TasksRepository with StreamableChanges<TaskChange> {
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
      addChange(TaskAdded(task));
    });
  }

  Future<Result<void, Exception>> update(Task task) async {
    return Result.tryCatch(() async {
      await _database.update(task.id, task.toMap());
      addChange(TaskUpdated(task));
    });
  }

  Future<Result<void, Exception>> delete(String id) async {
    return Result.tryCatch(() async {
      await _database.delete(id);
      addChange(TaskDeleted(id));
    });
  }
}

sealed class TaskChange {}

final class TaskAdded extends TaskChange {
  TaskAdded(this.task);

  final Task task;
}

final class TaskUpdated extends TaskChange {
  TaskUpdated(this.task);

  final Task task;
}

final class TaskDeleted extends TaskChange {
  TaskDeleted(this.taskId);

  final String taskId;
}
