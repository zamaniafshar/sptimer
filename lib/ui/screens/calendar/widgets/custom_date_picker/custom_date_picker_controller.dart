import 'package:get/get.dart';
import 'package:pomotimer/utils/utils.dart';

const kMonthOfYear_getbuilderkey = 'kMonthOfYear_getbuilder';
const kDaysOfWeek_getbuilderkey = 'kDaysOfWeek_getbuilderkey';
const kMinNumberOfWeek = 1;

class CustomDatePickerController extends GetxController {
  late int _month;
  late int _year;
  late int _currentWeek;
  late DateTime _selectedDate;
  late DateTime _today;
  List<DateTime> _daysOfMonth = [];

  DateTime get selectedDate => _selectedDate;
  DateTime get today => _today;
  int get maxNumberOfWeek => _getWeek(date: daysOfMonth.last)!;
  int get month => _month;
  int get year => _year;
  int get currentWeek => _currentWeek;
  List<DateTime> get daysOfMonth => _daysOfMonth;
  void Function(DateTime date)? onSelectedDateChanged;

  set selectedDate(DateTime newDate) {
    _selectedDate = newDate;
    _year = newDate.year;
    _month = newDate.month;
    _daysOfMonth = _getDaysOfMonth(month);
    _currentWeek = _getWeek(date: _selectedDate)!;
    update([kDaysOfWeek_getbuilderkey, kMonthOfYear_getbuilderkey]);
  }

  void init(DateTime lastRecordedTask) {
    _today = DateTime.now().roundToDay;
    _month = lastRecordedTask.month;
    _year = lastRecordedTask.year;
    _selectedDate = DateTime(year, month, lastRecordedTask.day);

    _daysOfMonth = _getDaysOfMonth(month);
    _currentWeek = _getWeek(date: _selectedDate)!;
  }

  void onWeekChanged(bool forward) {
    forward ? _currentWeek++ : _currentWeek--;
    _currentWeek = currentWeek > maxNumberOfWeek ? kMinNumberOfWeek : maxNumberOfWeek;
    update([kDaysOfWeek_getbuilderkey]);
  }

  void onDayChanged(DateTime newDate) {
    if (newDate.isInSameDay(_selectedDate)) return;
    _selectedDate = newDate;
    _daysOfMonth = _getDaysOfMonth(month);
    _currentWeek = _getWeek(date: _selectedDate)!;
    onSelectedDateChanged?.call(_selectedDate);
    update([kDaysOfWeek_getbuilderkey]);
  }

  void onMonthDecrement() {
    if (month == 1) {
      _year--;
    }
    _month = _getSafeMonth(month - 1);
    _daysOfMonth = _getDaysOfMonth(month);
    _resetCurrentWeek(false);
    update([kMonthOfYear_getbuilderkey, kDaysOfWeek_getbuilderkey]);
  }

  void onMonthIncrement() {
    if (month == 12) {
      _year++;
    }
    _month = _getSafeMonth(month + 1);
    _daysOfMonth = _getDaysOfMonth(month);
    _resetCurrentWeek(true);
    update([kMonthOfYear_getbuilderkey, kDaysOfWeek_getbuilderkey]);
  }

  List<DateTime> getDaysOfWeek(int week) {
    final List<DateTime> result = [];
    int beginIndex = 0;
    int endIndex = 0;
    _getWeek(
      currentWeek: week,
      onFind: (index, date) {
        beginIndex = index;
        endIndex = DateTime.daysPerWeek - (date.weekday == 7 ? 0 : date.weekday);
        endIndex += beginIndex;
        endIndex = endIndex >= daysOfMonth.length ? daysOfMonth.length : endIndex;
      },
    );
    result.addAll(daysOfMonth.sublist(beginIndex, endIndex));
    if (endIndex - beginIndex < 7) {
      if (beginIndex == 0) {
        final otherMonthDays = _getDaysOfMonth(_getSafeMonth(month - 1));
        final otherMonthBeginIndex = otherMonthDays.length - daysOfMonth.first.weekday;
        result.insertAll(0, otherMonthDays.sublist(otherMonthBeginIndex));
      } else if (endIndex == daysOfMonth.length) {
        final otherMonthDays = _getDaysOfMonth(_getSafeMonth(month + 1));
        final otherMonthBeginIndex =
            daysOfMonth.last.weekday == 7 ? 6 : 6 - daysOfMonth.last.weekday;
        result.addAll(otherMonthDays.sublist(0, otherMonthBeginIndex));
      }
    }

    return result;
  }

  int? _getWeek(
      {DateTime? date,
      int? currentWeek,
      void Function(int index, DateTime startDayOfWeek)? onFind}) {
    int week = daysOfMonth.first.weekday == DateTime.sunday ? 0 : 1;
    int weekDay;
    for (int i = 0; i < daysOfMonth.length; i++) {
      weekDay = daysOfMonth[i].weekday;
      if (weekDay > DateTime.saturday) {
        week++;
      }
      final condition = date == null ? week == currentWeek : daysOfMonth[i].day == date.day;
      if (condition) {
        onFind?.call(i, daysOfMonth[i]);
        return week;
      }
    }
    return null;
  }

  List<DateTime> _getDaysOfMonth(int month) {
    final List<DateTime> result = [];
    for (var i = 1; i <= kNumberOfDayEachMonth[month - 1]; i++) {
      final day = DateTime(year, month, i);
      result.add(day);
    }
    return result;
  }

  void _resetCurrentWeek(bool isIncrement) {
    if (selectedDate.month == month) {
      _currentWeek = _getWeek(date: selectedDate)!;
    } else if (isIncrement) {
      _currentWeek = 1;
    } else {
      _currentWeek = _getWeek(date: daysOfMonth.last)!;
    }
  }
}

int _getSafeMonth(int month) {
  if (month > 12) {
    return 1;
  } else if (month < 1) {
    return 12;
  } else {
    return month;
  }
}
