// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get addTask => 'Add New Task';

  @override
  String get addTaskTitle => 'Add New Task';

  @override
  String get appDescription =>
      'Using pomodoro technique and customizability we will help you to be more focused and reduces your fatigue while doing daily tasks.';

  @override
  String get appMotto => 'More focus, Better results, Less fatigue';

  @override
  String get baseScreenHome => 'Home';

  @override
  String get cancel => 'Cancel';

  @override
  String get cancelPomodoroTimerTitle => 'Do you want to cancel the time?';

  @override
  String get continueText => 'Continue';

  @override
  String get done => 'Done';

  @override
  String get editTaskTitle => 'Edit Task';

  @override
  String get failureMessage => 'Something went wrong.';

  @override
  String get howToUseAppDescription =>
      'Divide your daily tasks into desired time sections and after each work section, you can take a short break and after completing the number of work sections, you give yourself a long break to maintain mental and physical readiness.';

  @override
  String get howToUseAppTitle => 'How to use it?';

  @override
  String get ignoreBatteryOptimizeDescription =>
      'Sptimer can\'t work perfectly if Battery Optimization is on.';

  @override
  String get ignoreBatteryOptimizeTitle => 'Ignore Battery Optimization Permission';

  @override
  String get intervals => 'Intervals';

  @override
  String get longBreak => 'Long Break';

  @override
  String longBreakDescription(Object minutes) {
    return 'Take a Long Break for $minutes minutes';
  }

  @override
  String get longBreakTimePrefix => 'LB';

  @override
  String get minutes => 'Minutes';

  @override
  String get noDoneTasksDescription => 'You have no done task yet';

  @override
  String get noDoneTasksTitle => 'No Done Task';

  @override
  String get noRemainedTasksDescription => 'congratulation, you done all today tasks.';

  @override
  String get noRemainedTasksTitle => 'Good job! All Done';

  @override
  String get noTasksDescription => 'Please add some task by using below add button.';

  @override
  String get noTasksTitle => 'You Have No Task!';

  @override
  String get notificationPermissionDescription =>
      'Enable notification so you can see timer status when app closed.';

  @override
  String get notificationPermissionTitle => 'Show Notification Permission';

  @override
  String get okIUnderstand => 'Ok,I understand';

  @override
  String get pomodoroTimerFinishedMessage => 'Good job! your pomodoro task has been completed.';

  @override
  String get readPomodoroStatusDescription => 'Read pomodoro time status aloud.';

  @override
  String get readStatusTitle => 'Read Status';

  @override
  String get retry => 'Retry';

  @override
  String get rounds => 'Rounds';

  @override
  String get saveTask => 'Save Task';

  @override
  String get selectedTone => 'Selected Tone: ';

  @override
  String get shortBreak => 'Short Break';

  @override
  String shortBreakDescription(Object minutes) {
    return 'Take a Short Break for $minutes minutes';
  }

  @override
  String get skip => 'Skip';

  @override
  String get soundSettingsMuteMessage => 'Sound settings sets to mute.';

  @override
  String subtitleDescription(Object maxRound, Object round) {
    return '$round of $maxRound session';
  }

  @override
  String get taskName => 'Task name';

  @override
  String get taskNameError => 'Please enter name.';

  @override
  String get taskNameTooLongError => 'Too long.';

  @override
  String get tasksScreenAll => 'All';

  @override
  String get tasksScreenDelete => 'Delete';

  @override
  String get tasksScreenDone => 'Done';

  @override
  String get tasksScreenEdit => 'Edit';

  @override
  String get tasksScreenError => 'Something went wrong.';

  @override
  String get tasksScreenRemain => 'Remain';

  @override
  String get tasksScreenShortBreakTimePrefix => 'SB';

  @override
  String get tasksScreenTimeSuffix => 'm';

  @override
  String get tasksScreenTitle => 'Tasks';

  @override
  String get tasksScreenWorkTimePrefix => 'W';

  @override
  String get toneAndVolumeTitle => 'Tone and Volume';

  @override
  String get vibrationDescription => 'Add vibration when an event comes.';

  @override
  String get vibrationTitle => 'Vibration';

  @override
  String get whatIsPomodoroDescription =>
      'In simple words: Pomodoro is a technique for improve your results and help you to focus on your works.';

  @override
  String get whatIsPomodoroTitle => 'What is pomodoro?';

  @override
  String get workIntervals => 'Work Interval';

  @override
  String workTimeDescription(Object minutes) {
    return 'Stay focus for $minutes minutes';
  }

  @override
  String get appIntroductionAppMotto => 'More focus, Better results, Less fatigue';

  @override
  String get appIntroductionAppDescription =>
      'Using pomodoro technique and customizability we will help you to be more focused '
      'and reduces your fatigue while doing daily tasks.';

  @override
  String get appIntroductionWhatIsPomodoro => 'What is pomodoro?';

  @override
  String get appIntroductionWhatIsPomodoroDescription =>
      'In simple words: Pomodoro is a technique for improve your results and help you to focus on your works.';

  @override
  String get appIntroductionHowToUse => 'How to use it?';

  @override
  String get appIntroductionHowToUseDescription =>
      'Divide your daily tasks into desired time sections and after each work section,'
      ' you can take a short break and after completing the number of work sections, you give yourself a long break'
      ' to maintain mental and physical readiness.';

  @override
  String get appIntroductionDone => 'Done';

  @override
  String get appIntroductionSkip => 'Skip';
}
