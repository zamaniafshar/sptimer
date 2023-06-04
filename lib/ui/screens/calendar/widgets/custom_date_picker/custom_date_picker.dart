import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sptimer/ui/screens/calendar/widgets/custom_date_picker/constants.dart';
import 'package:sptimer/ui/screens/calendar/widgets/custom_date_picker/custom_date_picker_controller.dart';

import 'widgets/days_of_week.dart';
import 'widgets/months_of_year.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({Key? key, required this.controller}) : super(key: key);

  final CustomDatePickerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<CustomDatePickerController>(
          key: ValueKey(controller.hashCode),
          id: kMonthOfYear_getbuilderkey,
          global: false,
          init: controller,
          builder: (_) {
            return MonthOfYear(
              year: controller.year,
              month: controller.month,
              monthsNames: controller.monthsNames,
              onDecrement: controller.onMonthDecrement,
              onIncrement: controller.onMonthIncrement,
            );
          },
        ),
        25.verticalSpace,
        GetBuilder<CustomDatePickerController>(
          key: ValueKey(controller.hashCode + 1),
          id: kDaysOfWeek_getbuilderkey,
          global: false,
          init: controller,
          builder: (_) {
            return DayOfWeek(
              dayOfWeekNames: controller.daysOfWeekNames,
              maxNumberOfWeek: controller.maxNumberOfWeek,
              selectedDay: controller.selectedDate,
              today: controller.today,
              month: controller.month,
              currentWeek: controller.currentWeek,
              onWeekChange: controller.onWeekChanged,
              onDayChange: controller.onDayChanged,
              dayOfWeekGenerator: controller.getDaysOfWeek,
            );
          },
        ),
      ],
    );
  }
}
