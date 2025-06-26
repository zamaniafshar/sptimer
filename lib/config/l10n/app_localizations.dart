import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
  ];

  /// No description provided for @addTask.
  ///
  /// In en, this message translates to:
  /// **'Add New Task'**
  String get addTask;

  /// No description provided for @addTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New Task'**
  String get addTaskTitle;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'Using pomodoro technique and customizability we will help you to be more focused and reduces your fatigue while doing daily tasks.'**
  String get appDescription;

  /// No description provided for @appMotto.
  ///
  /// In en, this message translates to:
  /// **'More focus, Better results, Less fatigue'**
  String get appMotto;

  /// No description provided for @baseScreenHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get baseScreenHome;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cancelPomodoroTimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Do you want to cancel the time?'**
  String get cancelPomodoroTimerTitle;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @editTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get editTaskTitle;

  /// No description provided for @failureMessage.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get failureMessage;

  /// No description provided for @howToUseAppDescription.
  ///
  /// In en, this message translates to:
  /// **'Divide your daily tasks into desired time sections and after each work section, you can take a short break and after completing the number of work sections, you give yourself a long break to maintain mental and physical readiness.'**
  String get howToUseAppDescription;

  /// No description provided for @howToUseAppTitle.
  ///
  /// In en, this message translates to:
  /// **'How to use it?'**
  String get howToUseAppTitle;

  /// No description provided for @ignoreBatteryOptimizeDescription.
  ///
  /// In en, this message translates to:
  /// **'Sptimer can\'t work perfectly if Battery Optimization is on.'**
  String get ignoreBatteryOptimizeDescription;

  /// No description provided for @ignoreBatteryOptimizeTitle.
  ///
  /// In en, this message translates to:
  /// **'Ignore Battery Optimization Permission'**
  String get ignoreBatteryOptimizeTitle;

  /// No description provided for @intervals.
  ///
  /// In en, this message translates to:
  /// **'Intervals'**
  String get intervals;

  /// No description provided for @longBreak.
  ///
  /// In en, this message translates to:
  /// **'Long Break'**
  String get longBreak;

  /// No description provided for @longBreakDescription.
  ///
  /// In en, this message translates to:
  /// **'Take a Long Break for {minutes} minutes'**
  String longBreakDescription(Object minutes);

  /// No description provided for @longBreakTimePrefix.
  ///
  /// In en, this message translates to:
  /// **'LB'**
  String get longBreakTimePrefix;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// No description provided for @noDoneTasksDescription.
  ///
  /// In en, this message translates to:
  /// **'You have no done task yet'**
  String get noDoneTasksDescription;

  /// No description provided for @noDoneTasksTitle.
  ///
  /// In en, this message translates to:
  /// **'No Done Task'**
  String get noDoneTasksTitle;

  /// No description provided for @noRemainedTasksDescription.
  ///
  /// In en, this message translates to:
  /// **'congratulation, you done all today tasks.'**
  String get noRemainedTasksDescription;

  /// No description provided for @noRemainedTasksTitle.
  ///
  /// In en, this message translates to:
  /// **'Good job! All Done'**
  String get noRemainedTasksTitle;

  /// No description provided for @noTasksDescription.
  ///
  /// In en, this message translates to:
  /// **'Please add some task by using below add button.'**
  String get noTasksDescription;

  /// No description provided for @noTasksTitle.
  ///
  /// In en, this message translates to:
  /// **'You Have No Task!'**
  String get noTasksTitle;

  /// No description provided for @notificationPermissionDescription.
  ///
  /// In en, this message translates to:
  /// **'Enable notification so you can see timer status when app closed.'**
  String get notificationPermissionDescription;

  /// No description provided for @notificationPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Show Notification Permission'**
  String get notificationPermissionTitle;

  /// No description provided for @okIUnderstand.
  ///
  /// In en, this message translates to:
  /// **'Ok,I understand'**
  String get okIUnderstand;

  /// No description provided for @pomodoroTimerFinishedMessage.
  ///
  /// In en, this message translates to:
  /// **'Good job! your pomodoro task has been completed.'**
  String get pomodoroTimerFinishedMessage;

  /// No description provided for @readPomodoroStatusDescription.
  ///
  /// In en, this message translates to:
  /// **'Read pomodoro time status aloud.'**
  String get readPomodoroStatusDescription;

  /// No description provided for @readStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Read Status'**
  String get readStatusTitle;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @rounds.
  ///
  /// In en, this message translates to:
  /// **'Rounds'**
  String get rounds;

  /// No description provided for @saveTask.
  ///
  /// In en, this message translates to:
  /// **'Save Task'**
  String get saveTask;

  /// No description provided for @selectedTone.
  ///
  /// In en, this message translates to:
  /// **'Selected Tone: '**
  String get selectedTone;

  /// No description provided for @shortBreak.
  ///
  /// In en, this message translates to:
  /// **'Short Break'**
  String get shortBreak;

  /// No description provided for @shortBreakDescription.
  ///
  /// In en, this message translates to:
  /// **'Take a Short Break for {minutes} minutes'**
  String shortBreakDescription(Object minutes);

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @soundSettingsMuteMessage.
  ///
  /// In en, this message translates to:
  /// **'Sound settings sets to mute.'**
  String get soundSettingsMuteMessage;

  /// No description provided for @subtitleDescription.
  ///
  /// In en, this message translates to:
  /// **'{round} of {maxRound} session'**
  String subtitleDescription(Object maxRound, Object round);

  /// No description provided for @taskName.
  ///
  /// In en, this message translates to:
  /// **'Task name'**
  String get taskName;

  /// No description provided for @taskNameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter name.'**
  String get taskNameError;

  /// No description provided for @taskNameTooLongError.
  ///
  /// In en, this message translates to:
  /// **'Too long.'**
  String get taskNameTooLongError;

  /// No description provided for @tasksScreenAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get tasksScreenAll;

  /// No description provided for @tasksScreenDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get tasksScreenDelete;

  /// No description provided for @tasksScreenDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get tasksScreenDone;

  /// No description provided for @tasksScreenEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get tasksScreenEdit;

  /// No description provided for @tasksScreenError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get tasksScreenError;

  /// No description provided for @tasksScreenRemain.
  ///
  /// In en, this message translates to:
  /// **'Remain'**
  String get tasksScreenRemain;

  /// No description provided for @tasksScreenShortBreakTimePrefix.
  ///
  /// In en, this message translates to:
  /// **'SB'**
  String get tasksScreenShortBreakTimePrefix;

  /// No description provided for @tasksScreenTimeSuffix.
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get tasksScreenTimeSuffix;

  /// No description provided for @tasksScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasksScreenTitle;

  /// No description provided for @tasksScreenWorkTimePrefix.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get tasksScreenWorkTimePrefix;

  /// No description provided for @toneAndVolumeTitle.
  ///
  /// In en, this message translates to:
  /// **'Tone and Volume'**
  String get toneAndVolumeTitle;

  /// No description provided for @vibrationDescription.
  ///
  /// In en, this message translates to:
  /// **'Add vibration when an event comes.'**
  String get vibrationDescription;

  /// No description provided for @vibrationTitle.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get vibrationTitle;

  /// No description provided for @whatIsPomodoroDescription.
  ///
  /// In en, this message translates to:
  /// **'In simple words: Pomodoro is a technique for improve your results and help you to focus on your works.'**
  String get whatIsPomodoroDescription;

  /// No description provided for @whatIsPomodoroTitle.
  ///
  /// In en, this message translates to:
  /// **'What is pomodoro?'**
  String get whatIsPomodoroTitle;

  /// No description provided for @workIntervals.
  ///
  /// In en, this message translates to:
  /// **'Work Interval'**
  String get workIntervals;

  /// No description provided for @workTimeDescription.
  ///
  /// In en, this message translates to:
  /// **'Stay focus for {minutes} minutes'**
  String workTimeDescription(Object minutes);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
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
