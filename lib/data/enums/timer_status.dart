enum TimerStatus {
  started,
  paused,
  finished;

  bool get isStarted => this == TimerStatus.started;
  bool get isPaused => this == TimerStatus.paused;
  bool get isFinished => this == TimerStatus.finished;
}
