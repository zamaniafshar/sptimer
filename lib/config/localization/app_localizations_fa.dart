// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get addTask => 'اضافه کردن';

  @override
  String get addTaskTitle => 'اضافه کردن کار جدید';

  @override
  String get appDescription =>
      'با استفاده از تکنیک پومودورو و قابلیت شخصی‌سازی به شما کمک می‌کنیم تا تمرکز بیشتری داشته باشید و خستگی شما را در حین انجام کارهای روزانه کاهش می دهیم.';

  @override
  String get appMotto => 'تمرکز بیشتر، نتیجه بهتر، خستگی کمتر';

  @override
  String get baseScreenHome => 'خانه';

  @override
  String get cancel => 'توقف';

  @override
  String get cancelPomodoroTimerTitle => 'ایا میخواهید تایمر را متوقف کنید؟';

  @override
  String get continueText => 'ادامه';

  @override
  String get done => 'تمام';

  @override
  String get editTaskTitle => 'ویرایش کار';

  @override
  String get failureMessage => 'مشکلی پیش آمده است.';

  @override
  String get howToUseAppDescription =>
      ' کارهای روزانه خود را به بخش‌های زمانی دلخواه تقسیم کنید و پس از هر بخش کاری، می‌توانید یک استراحت کوتاه داشته باشید و پس از اتمام تعداد مشخصی از بخش‌های کاری، به خودتان یک استراحت طولانی بدهید تا آمادگی ذهنی و جسمی خود را حفظ کنید.';

  @override
  String get howToUseAppTitle => 'راهنمای برنامه';

  @override
  String get ignoreBatteryOptimizeDescription =>
      'اگر بهینه سازی باتری روشن باشد تایمر نمیتواند به خوبی کار کند.';

  @override
  String get ignoreBatteryOptimizeTitle => 'مجوز نادیده گرفتن بهینه سازی باتری';

  @override
  String get intervals => 'تعداد';

  @override
  String get longBreak => 'استراحت طولانی';

  @override
  String longBreakDescription(Object minutes) {
    return 'برای $minutes دقیقه استراحت کنید';
  }

  @override
  String get longBreakTimePrefix => 'ا.ط';

  @override
  String get minutes => 'دقیقه';

  @override
  String get noDoneTasksDescription => 'شما هنوزی کاری را انجام نداده اید.';

  @override
  String get noDoneTasksTitle => 'کار انجام شدای پیدا نشد!';

  @override
  String get noRemainedTasksDescription => 'تبریک شما همه کارهای امروز خود را انجام داده اید.';

  @override
  String get noRemainedTasksTitle => 'همه کار ها تمام شده!';

  @override
  String get noTasksDescription => 'لطفا کارهای خود را با دکمه اضافه در پایین اضافه نمایید.';

  @override
  String get noTasksTitle => 'شما کاری اضافه نکرده اید!';

  @override
  String get notificationPermissionDescription =>
      'اعلان ها را فعال کنید تا بتوانید هنگام بسته شدن برنامه وضعیت تایمر را ببینید.';

  @override
  String get notificationPermissionTitle => 'مجوز نشان دادن اعلان';

  @override
  String get okIUnderstand => 'باشه،متوجه شدم';

  @override
  String get pomodoroTimerFinishedMessage => 'تبریک! کار پومودورو شما به اتمام رسید.';

  @override
  String get readPomodoroStatusDescription => 'خواندن وضعیت تایمر با صدای بلند.';

  @override
  String get readStatusTitle => 'خواندن وضعیت';

  @override
  String get retry => 'تلاش مجدد';

  @override
  String get rounds => 'دورها';

  @override
  String get saveTask => 'ثبت تغییرات';

  @override
  String get selectedTone => 'صدای انتخاب شده:';

  @override
  String get shortBreak => 'استراحت کوتاه';

  @override
  String shortBreakDescription(Object minutes) {
    return 'برای $minutes دقیقه استراحت کوتاه کنید';
  }

  @override
  String get skip => 'رد شدن';

  @override
  String get soundSettingsMuteMessage => 'تنظیمات صدا بر روی حالت سکوت میباشد.';

  @override
  String subtitleDescription(Object maxRound, Object round) {
    return '$round از $maxRound دور';
  }

  @override
  String get taskName => 'اسم';

  @override
  String get taskNameError => 'لطفا اسم را وارد نمایید';

  @override
  String get taskNameTooLongError => 'طول اسم وارد شده بیش از حد طولانی باشد';

  @override
  String get tasksScreenAll => 'همه';

  @override
  String get tasksScreenDelete => 'حذف';

  @override
  String get tasksScreenDone => 'انجام شده';

  @override
  String get tasksScreenEdit => 'ویرایش';

  @override
  String get tasksScreenError => 'مشکلی پیش امده است.';

  @override
  String get tasksScreenRemain => 'باقی مانده';

  @override
  String get tasksScreenShortBreakTimePrefix => 'ا.ک';

  @override
  String get tasksScreenTimeSuffix => 'دقیقه';

  @override
  String get tasksScreenTitle => 'کارها';

  @override
  String get tasksScreenWorkTimePrefix => 'ک';

  @override
  String get toneAndVolumeTitle => 'صدا و درجه صدا';

  @override
  String get vibrationDescription => 'اضافه کردن ویبره وقتی یک رویداد تمام میشود.';

  @override
  String get vibrationTitle => 'ویبره';

  @override
  String get whatIsPomodoroDescription =>
      'به عبارت ساده: پومودورو تکنیکی است برای بهبود نتایج و کمک به شما برای تمرکز روی کارهایتان.';

  @override
  String get whatIsPomodoroTitle => 'پومودورو چیست؟';

  @override
  String get workIntervals => 'کار';

  @override
  String workTimeDescription(Object minutes) {
    return 'برای $minutes دقیقه تمرکز کنید';
  }

  @override
  String get appIntroductionAppMotto => 'تمرکز بیشتر، نتیجه بهتر، خستگی کمتر';

  @override
  String get appIntroductionAppDescription =>
      'با استفاده از تکنیک پومودورو و قابلیت شخصی‌سازی به شما کمک می‌کنیم تا تمرکز بیشتری داشته باشید و خستگی شما را در حین انجام کارهای روزانه کاهش می دهیم.';

  @override
  String get appIntroductionWhatIsPomodoro => 'پومودورو چیست؟';

  @override
  String get appIntroductionWhatIsPomodoroDescription =>
      'به عبارت ساده: پومودورو تکنیکی است برای بهبود نتایج و کمک به شما برای تمرکز روی کارهایتان.';

  @override
  String get appIntroductionHowToUse => 'راهنمای برنامه';

  @override
  String get appIntroductionHowToUseDescription =>
      'کارهای روزانه خود را به بخش های زمانی دلخواه تقسیم کنید و بعد از هر بخش کاری می توانید استراحت کوتاهی داشته باشید و پس از تکمیل تعداد قسمت های کاری، برای حفظ آمادگی روحی و جسمی به خود استراحتی طولانی بدهید.';

  @override
  String get appIntroductionDone => 'تمام';

  @override
  String get appIntroductionSkip => 'رد شدن';

  @override
  String get calendarTitle => 'تقویم';
}
