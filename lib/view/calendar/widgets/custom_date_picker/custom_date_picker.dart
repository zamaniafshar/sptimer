import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/logic/calendar/date_picker/custom_date_picker_cubit.dart';
import 'package:sptimer/logic/calendar/date_picker/custom_date_picker_state.dart';

import 'widgets/days_of_week.dart';
import 'widgets/months_of_year.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CustomDatePickerCubit, CustomDatePickerState>(
          builder: (context, state) {
            if (state.isLoading) return SizedBox();

            return MonthOfYear(
              year: state.year,
              month: state.month,
              monthsNames: state.monthsNames,
              onPreviousTap: () => context.read<CustomDatePickerCubit>().previousMonth(),
              onNextTap: () => context.read<CustomDatePickerCubit>().nextMonth(),
            );
          },
        ),
        25.verticalSpace,
        BlocBuilder<CustomDatePickerCubit, CustomDatePickerState>(
          builder: (context, state) {
            if (state.isLoading) return SizedBox();

            return DayOfWeek(
              dayOfWeekNames: state.daysOfWeekNames,
              maxNumberOfWeek: state.maxNumberOfWeek,
              selectedDay: state.selectedDate,
              today: state.today,
              month: state.month,
              currentWeek: state.currentWeek,
              onDayChange: (date) {
                context.read<CustomDatePickerCubit>().changeSelectedDate(date);
              },
              dayOfWeekGenerator: (week) {
                return context.read<CustomDatePickerCubit>().getDaysOfWeek(week);
              },
            );
          },
        ),
      ],
    );
  }
}
