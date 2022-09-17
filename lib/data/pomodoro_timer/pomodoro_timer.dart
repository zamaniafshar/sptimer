import 'package:complete_timer/complete_timer.dart';
import 'package:pomotimer/data/enum/pomodoro_status.dart';
import 'package:pomotimer/data/enum/timer_status.dart';
import 'package:pomotimer/data/models/pomodoro_model.dart';
import 'package:pomotimer/data/services/sound_player/sound_player.dart';

class PomodoroTimer {
  PomodoroTimer({
    required PomodoroTaskModel initState,
    this.onRestartTimer,
    this.onFinish,
  }) : _state = initState {
    _initTimer();
  }

  final Future<void> Function(PomodoroTaskModel)? onRestartTimer;
  final Future<void> Function(PomodoroTaskModel)? onFinish;

  late CompleteTimer _timer;
  PomodoroTaskModel _state;

  void Function()? _listener;

  // int get _maxSeconds => (_pomodoroStatus.isWorkTime ?  : kDurationOfRestTime).inSeconds;
  // int get pomodoroRound => _pomodoroRound;
  // int get maxPomodoroRound => _maxRound;
  // bool get isWorkTime => _isWorkTime;
  // bool get isStarted => _timer.isRunning;
  // Duration get maxDuration => _isWorkTime ? kDurationOfWorkTime : kDurationOfRestTime;
  // Duration get remainingDuration => Duration(seconds: _remainingSeconds);

  PomodoroTaskModel get state => _state;
  


  void listen(void Function() listener) {
    _listener = listener;
  }

  void start() {
    _state = _state.copyWith(
      timerStatus: TimerStatus.start,
    );
    _timer.start();
    _listener?.call();
  }

  void stop() {
    _state = _state.copyWith(
      timerStatus: TimerStatus.stop,
    );
    _timer.stop();
  }

  void cancel() {
    _state = _state.copyWith(
        timerStatus: TimerStatus.cancel,
        pomodoroStatus: PomodoroStatus.work,
        pomodoroRound: 1,
        currentRemainingDuration: );
    _timer.cancel();
    _isWorkTime = true;
    _pomodoroRound = 1;
    _remainingSeconds = _maxSeconds;
  }

  Future<void> _onTimerFinish() async {
    _timer.cancel();
    _isWorkTime = !_isWorkTime;
    _playSound();
    if (_isWorkTime) _pomodoroRound++;

    if (_pomodoroRound >= _maxRound! && !_isWorkTime) {
      cancel();
      await onFinish?.call(state);
      return;
    }
    _remainingSeconds = _maxSeconds;
    await onRestartTimer?.call(state);
    _timer.start();
  }

  void _playSound() {
    _isWorkTime ? PomodoroSoundPlayer.playWorkTime() : PomodoroSoundPlayer.playRestTime();
  }

  void a(CompleteTimer timer) {
    print('hey hey');
    _remainingSeconds--;
    _listener?.call();
    if (_remainingSeconds == 0) {
      _onTimerFinish();
      _listener?.call();
    }
  }

  void _initTimer() {
    _timer = CompleteTimer(
      duration: const Duration(seconds: 1),
      callback: a,
      autoStart: false,
      periodic: true,
    );
  }
}
