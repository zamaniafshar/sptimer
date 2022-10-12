enum CircleAnimatedButtonStatus {
  started,
  pause,
  resumed,
  finished;

  bool get isStarted => this == started;
  bool get isPaused => this == pause;
  bool get isResumed => this == resumed;
  bool get isFinished => this == finished;
}
