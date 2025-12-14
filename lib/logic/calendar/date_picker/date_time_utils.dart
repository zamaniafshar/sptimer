import 'package:shamsi_date/shamsi_date.dart';

const kPersianDaysOfWeekName = [
  'ش',
  'ی',
  'د',
  'س',
  'چ',
  'پ',
  'ج',
];

const kPersianMonthsNames = [
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

const kEnglishDaysOfWeekName = [
  'M',
  'T',
  'W',
  'T',
  'F',
  'S',
  'S',
];

const kEnglishMonthsNames = [
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

const kMinNumberOfWeek = 1;

extension DateTimeHelper on DateTime {
  bool isInSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  DateTime get roundToDay => DateTime(year, month, day);

  String get convertToDateString => '$year/$month/$day';
}

extension DateHelper on Date {
  bool isInSameDay(Date other) => year == other.year && month == other.month && day == other.day;

  Date get roundToDay {
    if (this is Jalali) return Jalali(year, month, day);
    return Gregorian(year, month, day);
  }

  String get convertToDateString => '$year/$month/$day';
}
