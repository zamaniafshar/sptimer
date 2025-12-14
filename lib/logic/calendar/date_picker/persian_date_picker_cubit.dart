import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sptimer/data/repositories/tasks_reportage_repository.dart';
import 'package:sptimer/logic/calendar/date_picker/custom_date_picker_cubit.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:sptimer/logic/calendar/date_picker/custom_date_picker_state.dart';
import 'package:sptimer/logic/calendar/date_picker/date_time_utils.dart';

class PersianDatePickerCubit extends Cubit<CustomDatePickerState> implements CustomDatePickerCubit {
  PersianDatePickerCubit(this._reportageRepository)
    : super(
        CustomDatePickerState(
          daysOfWeekNames: kPersianDaysOfWeekName,
          monthsNames: kPersianMonthsNames,
          today: Jalali.now(),
          selectedDate: Jalali.now(),
          maxNumberOfWeek: 4,
          month: 1,
          year: 1,
          currentWeek: 1,
          daysOfMonth: const [],
          isLoading: true,
        ),
      ) {
    _init();
  }

  final TasksReportageRepository _reportageRepository;

  Future<void> _init() async {
    final latestReportage = await _reportageRepository.getLatestReportage();
    final today = Jalali.now().roundToDay;
    final latestReportageDate = latestReportage?.startDate.toJalali().roundToDay;
    final selectedDate = latestReportageDate ?? today;
    final daysOfMonth = _getDaysOfMonth(selectedDate.year, selectedDate.month);
    final week = _getWeek(date: selectedDate, daysOfMonth: daysOfMonth)!;

    emit(
      state.copyWith(
        today: today,
        month: selectedDate.month,
        year: selectedDate.year,
        selectedDate: selectedDate,
        daysOfMonth: daysOfMonth,
        currentWeek: week,
        isLoading: false,
        maxNumberOfWeek: _getWeek(date: daysOfMonth.last, daysOfMonth: daysOfMonth)!,
      ),
    );
  }

  @override
  void changeSelectedDate(Date newDate) {
    int maxNumberOfWeek = state.maxNumberOfWeek;
    List<Date> daysOfMonth = state.daysOfMonth;
    if (newDate.month != state.selectedDate.month) {
      daysOfMonth = _getDaysOfMonth(newDate.year, newDate.month);
      maxNumberOfWeek = _getWeek(date: daysOfMonth.last, daysOfMonth: daysOfMonth)!;
    }

    emit(
      state.copyWith(
        selectedDate: newDate,
        year: newDate.year,
        month: newDate.month,
        maxNumberOfWeek: maxNumberOfWeek,
        daysOfMonth: daysOfMonth,
        currentWeek: _getWeek(date: newDate, daysOfMonth: daysOfMonth)!,
      ),
    );
  }

  @override
  void changeSelectedDateTime(DateTime newDate) {
    final date = newDate.toJalali();
    changeSelectedDate(date);
  }

  @override
  void previousMonth() {
    int newYear = state.year;
    int newMonth = state.month - 1;
    if (newMonth < 1) {
      newMonth = 12;
      newYear--;
    }
    final newDaysOfMonth = _getDaysOfMonth(newYear, newMonth);
    final newWeek = _resetCurrentWeek(false, newMonth, newDaysOfMonth);

    emit(
      state.copyWith(
        month: newMonth,
        year: newYear,
        daysOfMonth: newDaysOfMonth,
        currentWeek: newWeek,
      ),
    );
  }

  @override
  void nextMonth() {
    int newYear = state.year;
    int newMonth = state.month + 1;
    if (newMonth > 12) {
      newMonth = 1;
      newYear++;
    }
    final newDaysOfMonth = _getDaysOfMonth(newYear, newMonth);
    final newWeek = _resetCurrentWeek(true, newMonth, newDaysOfMonth);

    emit(
      state.copyWith(
        month: newMonth,
        year: newYear,
        daysOfMonth: newDaysOfMonth,
        currentWeek: newWeek,
      ),
    );
  }

  @override
  List<Date> getDaysOfWeek(int week) {
    final List<Date> result = [];
    int beginIndex = 0;
    int endIndex = 0;
    _getWeek(
      currentWeek: week,
      daysOfMonth: state.daysOfMonth,
      onFind: (index, date) {
        beginIndex = index;
        endIndex = DateTime.daysPerWeek - (date.weekDay > 1 ? date.weekDay - 1 : 0);
        endIndex += beginIndex;
        endIndex = endIndex >= state.daysOfMonth.length ? state.daysOfMonth.length : endIndex;
      },
    );
    result.addAll(state.daysOfMonth.sublist(beginIndex, endIndex));
    if (endIndex - beginIndex < 7) {
      if (beginIndex == 0) {
        final otherMonthDays = _getDaysOfMonth(state.year, _getMonthSafe(state.month - 1));
        final otherMonthBeginIndex = otherMonthDays.length - state.daysOfMonth.first.weekDay + 1;
        result.insertAll(0, otherMonthDays.sublist(otherMonthBeginIndex));
      } else if (endIndex == state.daysOfMonth.length) {
        final otherMonthDays = _getDaysOfMonth(state.year, _getMonthSafe(state.month + 1));
        final otherMonthEndIndex = 7 - state.daysOfMonth.last.weekDay;
        result.addAll(otherMonthDays.sublist(0, otherMonthEndIndex));
      }
    }

    return result;
  }

  int? _getWeek({
    required List<Date> daysOfMonth,
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

  List<Date> _getDaysOfMonth(int year, int month) {
    final List<Date> result = [];
    final jalaliDate = Jalali(year, month);
    for (var i = 1; i <= jalaliDate.monthLength; i++) {
      final day = Jalali(year, month, i);
      result.add(day);
    }
    return result;
  }

  int _resetCurrentWeek(
    bool isIncrement,
    int newMonth,
    List<Date> newDaysOfMonth,
  ) {
    if (isIncrement) {
      return 1;
    } else {
      return _getWeek(date: newDaysOfMonth.last, daysOfMonth: newDaysOfMonth)!;
    }
  }

  int _getMonthSafe(int month) {
    if (month > 12) return 1;
    if (month < 1) return 12;
    return month;
  }
}
