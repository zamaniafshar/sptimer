import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
  ];

  String get addTask;
  String get addTaskTitle;
  String get appDescription;
  String get appMotto;
  String get baseScreenHome;
  String get cancel;
  String get cancelPomodoroTimerTitle;
  String get continueText;
  String get done;
  String get editTaskTitle;
  String get failureMessage;
  String get howToUseAppDescription;
  String get howToUseAppTitle;
  String get ignoreBatteryOptimizeDescription;
  String get ignoreBatteryOptimizeTitle;
  String get intervals;
  String get longBreak;
  String longBreakDescription(Object minutes);
  String get longBreakTimePrefix;
  String get minutes;
  String get noDoneTasksDescription;
  String get noDoneTasksTitle;
  String get noRemainedTasksDescription;
  String get noRemainedTasksTitle;
  String get noTasksDescription;
  String get noTasksTitle;
  String get notificationPermissionDescription;
  String get notificationPermissionTitle;
  String get okIUnderstand;
  String get pomodoroTimerFinishedMessage;
  String get readPomodoroStatusDescription;
  String get readStatusTitle;
  String get retry;
  String get rounds;
  String get saveTask;
  String get selectedTone;
  String get shortBreak;
  String shortBreakDescription(Object minutes);
  String get skip;
  String get soundSettingsMuteMessage;
  String subtitleDescription(Object maxRound, Object round);
  String get taskName;
  String get taskNameError;
  String get taskNameTooLongError;
  String get tasksScreenAll;
  String get tasksScreenDelete;
  String get tasksScreenDone;
  String get tasksScreenEdit;
  String get tasksScreenError;
  String get tasksScreenRemain;
  String get tasksScreenShortBreakTimePrefix;
  String get tasksScreenTimeSuffix;
  String get tasksScreenTitle;
  String get tasksScreenWorkTimePrefix;
  String get toneAndVolumeTitle;
  String get vibrationDescription;
  String get vibrationTitle;
  String get whatIsPomodoroDescription;
  String get whatIsPomodoroTitle;
  String get workIntervals;
  String workTimeDescription(Object minutes);

  String get appIntroductionAppMotto;

  String get appIntroductionAppDescription;
  String get appIntroductionWhatIsPomodoro;
  String get appIntroductionWhatIsPomodoroDescription;
  String get appIntroductionHowToUse;
  String get appIntroductionHowToUseDescription;
  String get appIntroductionDone;
  String get appIntroductionSkip;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
