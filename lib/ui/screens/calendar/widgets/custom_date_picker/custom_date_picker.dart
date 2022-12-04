import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pomotimer/ui/screens/calendar/widgets/custom_date_picker/custom_date_picker_controller.dart';
import 'package:pomotimer/utils/utils.dart';

import 'widgets/days_of_week.dart';
import 'widgets/months_of_year.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<CustomDatePickerController>(
          id: kMonthOfYear_getbuilderkey,
          builder: (controller) {
            return MonthOfYear(
              year: controller.year,
              month: controller.month,
              monthsNames: kMonthsNames,
              onDecrement: controller.onMonthDecrement,
              onIncrement: controller.onMonthIncrement,
            );
          },
        ),
        25.verticalSpace,
        GetBuilder<CustomDatePickerController>(
          id: kDaysOfWeek_getbuilderkey,
          builder: (controller) {
            return DayOfWeek(
              dayOfWeekNames: kDayOfWeekName,
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
