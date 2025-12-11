import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:sptimer/data/repositories/tasks_reportage_repository.dart';
import 'package:sptimer/logic/calendar/date_picker/custom_date_picker_state.dart';
import 'package:sptimer/logic/calendar/date_picker/english_date_picker_cubit.dart';
import 'package:sptimer/logic/calendar/date_picker/persian_date_picker_cubit.dart';

enum DatePickerType {
  english,
  persian;

  bool get isEnglish => this == english;
  bool get isPersian => this == persian;
}

abstract class CustomDatePickerCubit implements Cubit<CustomDatePickerState> {
  factory CustomDatePickerCubit({
    required DatePickerType datePickerType,
    required TasksReportageRepository reportageRepository,
  }) {
    if (datePickerType.isEnglish) return EnglishDatePickerCubit(reportageRepository);
    return PersianDatePickerCubit(reportageRepository);
  }

  void changeSelectedDateTime(DateTime newDateTime);
  void changeSelectedDate(Date newDate);

  void previousMonth();

  void nextMonth();

  List<Date> getDaysOfWeek(int week);
}
