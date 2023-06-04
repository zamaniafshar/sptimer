import 'package:get/get.dart';
import 'package:sptimer/ui/screens/calendar/widgets/custom_date_picker/date_picker_controllers/english_date_picker_controller.dart';
import 'package:sptimer/ui/screens/calendar/widgets/custom_date_picker/date_picker_controllers/persian_date_picker_controller.dart';
import 'package:shamsi_date/shamsi_date.dart';

enum DatePickerType {
  english,
  persian;

  bool get isEnglish => this == english;
  bool get isPersian => this == persian;
}

abstract class CustomDatePickerController extends GetxController {
  factory CustomDatePickerController({
    required DatePickerType datePickerType,
  }) {
    if (datePickerType.isEnglish) return EnglishDatePickerController();
    return PersianDatePickerController();
  }

  List<String> get daysOfWeekNames;
  List<String> get monthsNames;

  DateTime get selectedDateTime;
  Date get today;
  Date get selectedDate;
  int get maxNumberOfWeek;
  int get month;
  int get year;
  int get currentWeek;
  List<Date> get daysOfMonth;
  void Function(DateTime date)? onSelectedDateChanged;

  set selectedDateTime(DateTime newDateTime);
  set selectedDate(Date newDate);

  void init(DateTime lastRecordedTask);

  void onWeekChanged(bool forward);

  void onDayChanged(Date newDate);

  void onMonthDecrement();

  void onMonthIncrement();

  List<Date> getDaysOfWeek(int week);
}
