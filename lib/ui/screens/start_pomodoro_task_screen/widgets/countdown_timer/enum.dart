enum CountdownTimerStatus {
  start,
  pause,
  resume,
  cancel;

  bool get isStart => this == start;
  bool get isPause => this == pause;
  bool get isResume => this == resume;
  bool get isCancel => this == cancel;
}
