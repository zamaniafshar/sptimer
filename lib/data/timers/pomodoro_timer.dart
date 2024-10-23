import 'package:complete_timer/complete_timer.dart';
import 'package:sptimer/data/databases/tasks_reportage_database.dart';
import 'package:sptimer/data/enums/pomodoro_status.dart';
import 'package:sptimer/data/enums/task_status.dart';
import 'package:sptimer/data/enums/timer_status.dart';
import 'package:sptimer/data/models/pomodoro_task.dart';
import 'package:sptimer/data/models/pomodoro_task_reportage.dart';
import 'package:sptimer/data/services/pomodoro_sound_player.dart';

class PomodoroTimer {
  PomodoroTimer({
    required this.task,
    required PomodoroSoundPlayer soundPlayer,
    required TasksReportageDatabase tasksReportageDatabase,
  })  : _soundPlayer = soundPlayer,
        _tasksReportageDatabase = tasksReportageDatabase {
    _initTimer();
    _soundPlayer.init();
  }

  final PomodoroTask task;
  final PomodoroSoundPlayer _soundPlayer;
  final TasksReportageDatabase _tasksReportageDatabase;

  late DateTime _startDate;
  late CompleteTimer _timer;
  int _pomodoroRound = 1;
  PomodoroStatus _pomodoroStatus = PomodoroStatus.work;
  TimerStatus _timerStatus = TimerStatus.finished;

  TimerStatus get timerStatus => _timerStatus;
  PomodoroStatus get pomodoroStatus => _pomodoroStatus;
  int get pomodoroRound => _pomodoroRound;
  Duration get remainingDuration => currentMaxDuration - _timer.elapsedTime;

  Duration get currentMaxDuration {
    if (_pomodoroStatus.isWorkTime) {
      return task.workDuration;
    } else if (_pomodoroStatus.isShortBreakTime) {
      return task.shortBreakDuration;
    } else {
      return task.longBreakDuration;
    }
  }

  void start() {
    _startDate = DateTime.now();
    _timerStatus = TimerStatus.started;
    _timer.start();
  }

  void pause() {
    _timerStatus = TimerStatus.paused;
    _timer.stop();
  }

  void resume() {
    _timerStatus = TimerStatus.started;
    _timer.start();
  }

  void finish() {
    _saveTaskReport(isCompleted: false);
    _resetState();
  }

  void _onTimerFinish(_) async {
    if (_pomodoroStatus.isLongBreakTime) {
      return _onTaskFinished();
    } else if (_pomodoroRound == task.maxPomodoroRound && pomodoroStatus.isWorkTime) {
      if (task.longBreakDuration == Duration.zero) {
        return _onTaskFinished();
      }

      _pomodoroStatus = PomodoroStatus.longBreak;
    } else if (_pomodoroStatus.isShortBreakTime) {
      _pomodoroRound++;
      _pomodoroStatus = PomodoroStatus.work;
    } else if (_pomodoroStatus.isWorkTime) {
      _pomodoroStatus = PomodoroStatus.shortBreak;
    }

    _soundPlayer.playPomodoroSound(
      task: task,
      pomodoroStatus: _pomodoroStatus,
    );
    _initTimer();
    _timer.start();
  }

  void _onTaskFinished() {
    _saveTaskReport(isCompleted: true);
    _resetState();
    _soundPlayer.playTone(task.tone);
  }

  void _initTimer() {
    _timer = CompleteTimer(
      duration: currentMaxDuration,
      callback: _onTimerFinish,
      autoStart: false,
      periodic: false,
    );
  }

  void _resetState() {
    _timerStatus = TimerStatus.finished;
    _pomodoroStatus = PomodoroStatus.work;
    _pomodoroRound = 1;
    _timer.cancel();
  }

  Future<void> _saveTaskReport({required bool isCompleted}) async {
    final taskReportage = PomodoroTaskReportage(
      pomodoroTaskId: task.id!,
      taskTitle: task.title,
      startDate: _startDate,
      endDate: DateTime.now(),
      taskStatus: isCompleted ? TaskStatus.completed : TaskStatus.uncompleted,
    );
    await _tasksReportageDatabase.add(taskReportage);
  }
}
