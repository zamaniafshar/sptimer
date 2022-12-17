import 'package:flutter/material.dart';

class AppTexts {
  const AppTexts({
    required this.appName,
    required this.fontFamily,
    required this.locale,
    required this.convertNumber,
    required this.convertDateToString,
    required this.tasksScreenTitle,
    required this.tasksScreenAll,
    required this.tasksScreenDone,
    required this.tasksScreenRemain,
    required this.tasksScreenNoDoneTasksTitle,
    required this.tasksScreenNoDoneTasksDescription,
    required this.tasksScreenNoTasksTitle,
    required this.tasksScreenNoTasksDescription,
    required this.tasksScreenNoRemainedTasksTitle,
    required this.tasksScreenNoRemainedTasksDescription,
    required this.tasksScreenError,
    required this.tasksScreenWorkTimePrefix,
    required this.tasksScreenLongBreakTimePrefix,
    required this.tasksScreenShortBreakTimePrefix,
    required this.tasksScreenTimeSuffix,
    required this.tasksScreenEdit,
    required this.tasksScreenDelete,
    required this.baseScreenHome,
    required this.baseScreenCalendar,
    required this.calendarScreenTitle,
    required this.calendarScreenRemain,
    required this.calendarScreenDone,
    required this.calendarScreenEmptyListTitle,
    required this.calendarScreenEmptyListDescription,
    required this.calendarScreenNoRecordedTasksFound,
    required this.calendarScreenError,
    required this.calendarScreenTimeSuffix,
    required this.addPomodoroScreenAddTitle,
    required this.addPomodoroScreenEditTitle,
    required this.addPomodoroScreenAddButton,
    required this.addPomodoroScreenEditButton,
    required this.addPomodoroScreenRounds,
    required this.addPomodoroScreenIntervals,
    required this.addPomodoroScreenWorkIntervals,
    required this.addPomodoroScreenShortBreak,
    required this.addPomodoroScreenLongBreak,
    required this.addPomodoroScreenMinutes,
    required this.addPomodoroScreenTaskName,
    required this.addPomodoroScreenVibrationTitle,
    required this.addPomodoroScreenVibrationDescription,
    required this.addPomodoroScreenReadStatusTitle,
    required this.addPomodoroScreenReadStatusDescription,
    required this.addPomodoroScreenToneAndVolume,
    required this.addPomodoroScreenSelectedTone,
    required this.addPomodoroScreenTaskNameError,
    required this.addPomodoroScreenTaskNameTooLongError,
    required this.addPomodoroScreenSoundSettingMute,
    required this.startPomodoroTaskScreenCancelTimerTitle,
    required this.startPomodoroTaskScreenCancel,
    required this.startPomodoroTaskScreenContinue,
    required this.startPomodoroTaskScreenPomodoroFinish,
    required this.startPomodoroTaskScreenSoundSettingsSetToMute,
    required this.getSubtitleText,
    required this.getWorkTimeText,
    required this.getShortBreakText,
    required this.getLongBreakText,
  });

  final String appName;
  final String fontFamily;
  final Locale locale;
  final String Function(String number) convertNumber;
  final String Function(DateTime date) convertDateToString;
  // tasks screen texts:
  final String tasksScreenTitle;
  final String tasksScreenAll;
  final String tasksScreenDone;
  final String tasksScreenRemain;
  final String tasksScreenNoDoneTasksTitle;
  final String tasksScreenNoDoneTasksDescription;
  final String tasksScreenNoTasksTitle;
  final String tasksScreenNoTasksDescription;
  final String tasksScreenNoRemainedTasksTitle;
  final String tasksScreenNoRemainedTasksDescription;
  final String tasksScreenError;
  final String tasksScreenWorkTimePrefix;
  final String tasksScreenLongBreakTimePrefix;
  final String tasksScreenShortBreakTimePrefix;
  final String tasksScreenTimeSuffix;
  final String tasksScreenEdit;
  final String tasksScreenDelete;

  // base screen texts:
  final String baseScreenHome;
  final String baseScreenCalendar;

  // calendar screen texts:
  final String calendarScreenTitle;
  final String calendarScreenRemain;
  final String calendarScreenDone;
  final String calendarScreenEmptyListTitle;
  final String calendarScreenEmptyListDescription;
  final String calendarScreenNoRecordedTasksFound;
  final String calendarScreenError;
  final String Function(DateTime time) calendarScreenTimeSuffix;

  // add pomodoro screen texts:
  final String addPomodoroScreenAddTitle;
  final String addPomodoroScreenEditTitle;
  final String addPomodoroScreenAddButton;
  final String addPomodoroScreenEditButton;
  final String addPomodoroScreenRounds;
  final String addPomodoroScreenIntervals;
  final String addPomodoroScreenWorkIntervals;
  final String addPomodoroScreenShortBreak;
  final String addPomodoroScreenLongBreak;
  final String addPomodoroScreenMinutes;
  final String addPomodoroScreenTaskName;
  final String addPomodoroScreenVibrationTitle;
  final String addPomodoroScreenVibrationDescription;
  final String addPomodoroScreenReadStatusTitle;
  final String addPomodoroScreenReadStatusDescription;
  final String addPomodoroScreenToneAndVolume;
  final String addPomodoroScreenSelectedTone;
  final String addPomodoroScreenTaskNameError;
  final String addPomodoroScreenTaskNameTooLongError;
  final String addPomodoroScreenSoundSettingMute;

  // start pomodoro screen texts:

  final String startPomodoroTaskScreenCancelTimerTitle;
  final String startPomodoroTaskScreenCancel;
  final String startPomodoroTaskScreenContinue;
  final String startPomodoroTaskScreenPomodoroFinish;
  final String startPomodoroTaskScreenSoundSettingsSetToMute;

  final String Function(int round, int maxRound) getSubtitleText;
  final String Function(Duration time) getWorkTimeText;
  final String Function(Duration time) getShortBreakText;
  final String Function(Duration time) getLongBreakText;
}
