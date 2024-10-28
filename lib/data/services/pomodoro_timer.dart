import 'dart:async';

import 'package:complete_timer/complete_timer.dart';
import 'package:sptimer/data/repositories/tasks_reportage_repository.dart';
import 'package:sptimer/data/enums/pomodoro_status.dart';
import 'package:sptimer/data/enums/task_status.dart';
import 'package:sptimer/data/enums/timer_status.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/data/models/task_reportage.dart';
import 'package:sptimer/data/models/pomodoro_timer_state.dart';
import 'package:sptimer/data/services/pomodoro_sound_player.dart';

final class PomodoroTimer {
  PomodoroTimer({
    required Task task,
    required PomodoroSoundPlayer soundPlayer,
    required TasksReportageRepository tasksReportageDatabase,
  })  : _soundPlayer = soundPlayer,
        _tasksReportageDatabase = tasksReportageDatabase {
    _timer = CompleteTimer(
      duration: const Duration(seconds: 1),
      callback: _onTick,
      autoStart: false,
      periodic: true,
    );
    _soundPlayer.init();
    _state = PomodoroTimerState.initial(task: task);
  }

  final PomodoroSoundPlayer _soundPlayer;
  final TasksReportageRepository _tasksReportageDatabase;

  final _streamController = StreamController<PomodoroTimerState>();

  late PomodoroTimerState _state;
  late DateTime _startDate;
  late CompleteTimer _timer;

  PomodoroTimerState get state => _state;
  Stream<PomodoroTimerState> get streamState => _streamController.stream;

  void _setState(PomodoroTimerState state) {
    _state = state;
    _streamController.add(state);
  }

  Future<void> dispose() async {
    _timer.cancel();
    await _streamController.close();
  }

  void start() {
    if (!_state.timerStatus.isFinished) return;

    _startDate = DateTime.now();
    _setState(
      _state.copyWith(
        timerStatus: TimerStatus.started,
        pomodoroRound: 1,
        pomodoroStatus: PomodoroStatus.work,
        elapsedTime: Duration.zero,
      ),
    );
    _timer.start();
  }

  void pause() {
    if (!_state.timerStatus.isStarted) return;

    _setState(
      _state.copyWith(timerStatus: TimerStatus.paused),
    );
    _timer.stop();
  }

  void resume() {
    if (!_state.timerStatus.isPaused) return;

    _setState(
      _state.copyWith(timerStatus: TimerStatus.started),
    );
    _timer.start();
  }

  void finish() {
    if (_state.timerStatus.isFinished) return;

    _saveTaskReport(isCompleted: false);
    _setState(
      PomodoroTimerState.initial(task: _state.task),
    );
    _timer.cancel();
  }

  void restart() {
    if (_state.timerStatus.isFinished) return;

    _startDate = DateTime.now();
    _setState(
      _state.copyWith(
        timerStatus: TimerStatus.started,
        pomodoroRound: 1,
        pomodoroStatus: PomodoroStatus.work,
        elapsedTime: Duration.zero,
      ),
    );
    _timer.start();
  }

  void _onTick(_) async {
    _setState(
      _state.copyWith(elapsedTime: _timer.elapsedTime),
    );
    if (_timer.elapsedTime < _state.currentMaxDuration) return;

    if (_state.pomodoroStatus.isLongBreakTime) {
      return _onTaskFinished();
    } else {
      _handleTransition();
    }

    _soundPlayer.playPomodoroSound(
      task: _state.task,
      pomodoroStatus: _state.pomodoroStatus,
    );
  }

  void _handleTransition() {
    if (_isFinalWorkRound()) {
      if (_state.task.longBreakDuration == Duration.zero) return _onTaskFinished();

      _setState(
        _state.copyWith(pomodoroStatus: PomodoroStatus.longBreak),
      );
    } else if (_state.pomodoroStatus.isShortBreakTime) {
      _setState(
        _state.copyWith(
          pomodoroStatus: PomodoroStatus.longBreak,
          pomodoroRound: _state.pomodoroRound + 1,
        ),
      );
    } else {
      _setState(
        _state.copyWith(pomodoroStatus: PomodoroStatus.shortBreak),
      );
    }
  }

  bool _isFinalWorkRound() {
    return _state.pomodoroRound == _state.task.maxPomodoroRound && _state.pomodoroStatus.isWorkTime;
  }

  void _onTaskFinished() {
    _saveTaskReport(isCompleted: true);
    _setState(
      PomodoroTimerState.initial(task: _state.task),
    );
    _soundPlayer.playTone(_state.task.tone);
  }

  Future<void> _saveTaskReport({required bool isCompleted}) async {
    final taskReportage = TaskReportage(
      taskId: _state.task.id,
      taskTitle: _state.task.title,
      startDate: _startDate,
      endDate: DateTime.now(),
      taskStatus: isCompleted ? TaskStatus.completed : TaskStatus.uncompleted,
    );
    await _tasksReportageDatabase.add(taskReportage);
  }
}
