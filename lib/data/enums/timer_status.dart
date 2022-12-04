enum TimerStatus {
  start,
  stop,
  cancel;

  bool get isStarted => this == TimerStatus.start;
  bool get isStopped => this == TimerStatus.stop;
  bool get isCanceled => this == TimerStatus.cancel;
}
