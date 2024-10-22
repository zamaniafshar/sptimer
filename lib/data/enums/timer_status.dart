enum TimerStatus {
  started,
  paused,
  finished;

  bool get isStarted => this == TimerStatus.started;
  bool get isStopped => this == TimerStatus.paused;
  bool get isCanceled => this == TimerStatus.finished;
}
