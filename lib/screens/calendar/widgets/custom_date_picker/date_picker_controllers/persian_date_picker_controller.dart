import 'package:get/get.dart';
import 'package:sptimer/screens/calendar/widgets/custom_date_picker/constants.dart';
import 'package:sptimer/screens/calendar/widgets/custom_date_picker/custom_date_picker_controller.dart';
import 'package:sptimer/utils/utils.dart';
import 'package:shamsi_date/shamsi_date.dart';

class PersianDatePickerController extends GetxController implements CustomDatePickerController {
  late int _month;
  late int _year;
  late int _currentWeek;
  late Date _selectedDate;
  late Date _today;
  List<Date> _daysOfMonth = [];

  @override
  Date get selectedDate => _selectedDate;
  @override
  DateTime get selectedDateTime => _selectedDate.toDateTime();
  @override
  Date get today => _today;
  @override
  int get maxNumberOfWeek => _getWeek(date: daysOfMonth.last)!;
  @override
  int get month => _month;
  @override
  int get year => _year;
  @override
  int get currentWeek => _currentWeek;
  @override
  List<Date> get daysOfMonth => _daysOfMonth;
  @override
  List<String> get daysOfWeekNames => kPersianDaysOfWeekName;
  @override
  List<String> get monthsNames => kPersianMonthsNames;
  @override
  void Function(DateTime date)? onSelectedDateChanged;

  @override
  set selectedDate(Date newDate) {
    _selectedDate = newDate;
    _year = newDate.year;
    _month = newDate.month;
    _currentWeek = _getWeek(date: _selectedDate)!;
    update([kDaysOfWeek_getbuilderkey, kMonthOfYear_getbuilderkey]);
  }

  @override
  set selectedDateTime(DateTime newDate) {
    final date = newDate.toJalali();
    _daysOfMonth = _getDaysOfMonth(date.month);
    selectedDate = date;
  }

  @override
  void init(DateTime lastRecordedTask) {
    final date = lastRecordedTask.toJalali();
    _today = Jalali.now().roundToDay;
    _month = date.month;
    _year = date.year;
    _selectedDate = Jalali(year, month, date.day);

    _daysOfMonth = _getDaysOfMonth(month);
    _currentWeek = _getWeek(date: _selectedDate)!;
  }

  @override
  void onWeekChanged(bool forward) {
    forward ? _currentWeek++ : _currentWeek--;
    _currentWeek = currentWeek > maxNumberOfWeek ? kMinNumberOfWeek : maxNumberOfWeek;
    update([kDaysOfWeek_getbuilderkey]);
  }

  @override
  void onDayChanged(Date newDate) {
    if (newDate.isInSameDay(_selectedDate)) return;
    _selectedDate = newDate;
    _daysOfMonth = _getDaysOfMonth(month);
    _currentWeek = _getWeek(date: _selectedDate)!;
    onSelectedDateChanged?.call(_selectedDate.toDateTime());
    update([kDaysOfWeek_getbuilderkey]);
  }

  @override
  void onMonthDecrement() {
    if (month == 1) {
      _year--;
    }
    _month = getSafeMonth(month - 1);
    _daysOfMonth = _getDaysOfMonth(month);
    _resetCurrentWeek(false);
    update([kMonthOfYear_getbuilderkey, kDaysOfWeek_getbuilderkey]);
  }

  @override
  void onMonthIncrement() {
    if (month == 12) {
      _year++;
    }
    _month = getSafeMonth(month + 1);
    _daysOfMonth = _getDaysOfMonth(month);
    _resetCurrentWeek(true);
    update([kMonthOfYear_getbuilderkey, kDaysOfWeek_getbuilderkey]);
  }

  @override
  List<Date> getDaysOfWeek(int week) {
    final List<Date> result = [];
    int beginIndex = 0;
    int endIndex = 0;
    _getWeek(
      currentWeek: week,
      onFind: (index, date) {
        beginIndex = index;
        endIndex = DateTime.daysPerWeek - (date.weekDay > 1 ? date.weekDay - 1 : 0);
        endIndex += beginIndex;
        endIndex = endIndex >= daysOfMonth.length ? daysOfMonth.length : endIndex;
      },
    );
    result.addAll(daysOfMonth.sublist(beginIndex, endIndex));
    if (endIndex - beginIndex < 7) {
      if (beginIndex == 0) {
        final otherMonthDays = _getDaysOfMonth(getSafeMonth(month - 1));
        final otherMonthBeginIndex = otherMonthDays.length - daysOfMonth.first.weekDay + 1;
        result.insertAll(0, otherMonthDays.sublist(otherMonthBeginIndex));
      } else if (endIndex == daysOfMonth.length) {
        final otherMonthDays = _getDaysOfMonth(getSafeMonth(month + 1));
        final otherMonthEndIndex = 7 - daysOfMonth.last.weekDay;
        result.addAll(otherMonthDays.sublist(0, otherMonthEndIndex));
      }
    }

    return result;
  }

  int? _getWeek({
    Date? date,
    int? currentWeek,
    void Function(int index, Date startDayOfWeek)? onFind,
  }) {
    int week = daysOfMonth.first.weekDay == 1 ? 0 : 1;
    int weekDay;
    for (int i = 0; i < daysOfMonth.length; i++) {
      weekDay = daysOfMonth[i].weekDay;
      if (weekDay == 1) {
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

  List<Date> _getDaysOfMonth(int month) {
    final List<Date> result = [];
    final jalaliDate = Jalali(year, month);
    for (var i = 1; i <= jalaliDate.monthLength; i++) {
      final day = Jalali(year, month, i);
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
