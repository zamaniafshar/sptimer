enum PomodoroStatus {
  work,
  shortBreak,
  longBreak;

  bool get isWorkTime => this == PomodoroStatus.work;
  bool get isShortBreakTime => this == PomodoroStatus.shortBreak;
  bool get isLongBreakTime => this == PomodoroStatus.longBreak;
}
