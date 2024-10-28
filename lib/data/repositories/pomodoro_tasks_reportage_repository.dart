import 'dart:async';

import 'package:sptimer/data/models/pomodoro_task.dart';
import 'package:sptimer/data/models/pomodoro_task_reportage.dart';
import 'package:sptimer/utils/database.dart';
import 'package:sptimer/utils/extensions/extensions.dart';
import 'package:sptimer/utils/result.dart';

final class PomodoroTasksReportageRepository {
  PomodoroTasksReportageRepository(this._database);

  final Database _database;

  Future<Result<List<PomodoroTaskReportage>, Exception>> getTodayReportages() async {
    final today = DateTime.now();

    return getAllReportagesInDates(today, today);
  }

  Future<Result<List<PomodoroTaskReportage>, Exception>> getAllReportagesInDates(
    DateTime start,
    DateTime end,
  ) async {
    return Result.tryCatch(() async {
      final reportages = <PomodoroTaskReportage>[];
      for (int i = _database.keys.length - 1; i >= 0; i--) {
        final key = _database.keys.elementAt(i);
        final data = await _database.get(key);
        final task = PomodoroTaskReportage.fromMap(data);
        if (task.startDate.isBetweenDates(start, end)) {
          reportages.add(task);
        } else if (task.startDate.isBefore(start)) {
          break;
        }
      }
      return reportages;
    });
  }

  Future<Result<void, Exception>> add(PomodoroTaskReportage task) async {
    return Result.tryCatch(() async {
      await _database.save(task.id, task.toMap());
    });
  }

  Future<Result<void, Exception>> update(PomodoroTask pomodoroTaskModel) async {
    return Result.tryCatch(() async {
      for (var key in _database.keys) {
        final map = await _database.get(key);
        final reportageTask = PomodoroTaskReportage.fromMap(map);
        if (reportageTask.pomodoroTaskId == pomodoroTaskModel.id) {
          await _database.update(
            key,
            reportageTask.copyWith(taskTitle: pomodoroTaskModel.title).toMap(),
          );
        }
      }
    });
  }

  Future<Result<void, Exception>> delete(String pomodoroTaskId) async {
    return Result.tryCatch(() async {
      for (var key in _database.keys) {
        final map = await _database.get(key);
        final task = PomodoroTaskReportage.fromMap(map);
        if (task.pomodoroTaskId == pomodoroTaskId) {
          await _database.delete(key);
        }
      }
    });
  }
}

extension on DateTime {
  bool isBetweenDates(DateTime start, DateTime end) {
    if (isInSameDay(end) || isInSameDay(start)) return true;
    if (isBefore(end) && isAfter(start)) return true;
    return false;
  }
}
