import 'package:flutter/material.dart';

abstract final class Constants {
  static const persianLocale = Locale('fa');
  static const englishLocale = Locale('en');

  static const sansproFont = 'SourceSansPro';
  static const vazirFont = 'Vazir';

  static const taskReportageDB = 'pomodoroTaskReportageDB';

  static const vibrationPattern = [0, 300, 100, 300];

  static const persianDaysOfWeekName = [
    'ش',
    'ی',
    'د',
    'س',
    'چ',
    'پ',
    'ج',
  ];

  static const persianMonthsNames = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'ابان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];

  static const englishDaysOfWeekName = [
    'M',
    'T',
    'W',
    'T',
    'F',
    'S',
    'S',
  ];

  static const englishMonthsNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
}
