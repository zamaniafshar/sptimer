import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shamsi_date/shamsi_date.dart';

part 'custom_date_picker_state.freezed.dart';

@freezed
abstract class CustomDatePickerState with _$CustomDatePickerState {
  const CustomDatePickerState._();

  const factory CustomDatePickerState({
    required List<String> daysOfWeekNames,
    required List<String> monthsNames,
    required Date today,
    required Date selectedDate,
    required int maxNumberOfWeek,
    required int month,
    required int year,
    required int currentWeek,
    required List<Date> daysOfMonth,
    required bool isLoading,
  }) = _CustomDatePickerState;

  DateTime get selectedDateTime => selectedDate.toDateTime();
}
