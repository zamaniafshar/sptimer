import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'day_widget.dart';

class DayOfWeek extends StatefulWidget {
  const DayOfWeek({
    Key? key,
    required this.dayOfWeekNames,
    required this.dayOfWeekGenerator,
    required this.selectedDay,
    required this.onDayChange,
    required this.month,
    required this.today,
    required this.currentWeek,
    required this.maxNumberOfWeek,
  }) : super(key: key);

  final List<String> dayOfWeekNames;
  final Date selectedDay;
  final Date today;
  final int month;
  final int currentWeek;
  final int maxNumberOfWeek;
  final List<Date> Function(int week) dayOfWeekGenerator;
  final void Function(Date newDay) onDayChange;

  @override
  State<DayOfWeek> createState() => _DayOfWeekState();
}

class _DayOfWeekState extends State<DayOfWeek> {
  late PageController controller;

  @override
  void initState() {
    controller = PageController(initialPage: widget.currentWeek - 1, viewportFraction: 1.05);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DayOfWeek oldWidget) {
    Future.delayed(Duration.zero, () => controller.jumpToPage(widget.currentWeek - 1));
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final space = 10.h;
    final dayWidgetWidth = (ScreenUtil().screenWidth - (8 * space)) / DateTime.daysPerWeek;

    return SizedBox(
      height: 80.h,
      child: PageView.builder(
        itemCount: widget.maxNumberOfWeek,
        controller: controller,

        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (Date day in widget.dayOfWeekGenerator(index + 1))
                  DayWidget(
                    title: widget.dayOfWeekNames[day.weekDay - 1],
                    day: day.day.toString(),
                    width: dayWidgetWidth,
                    isSelected: widget.selectedDay == day,
                    isActive:
                        widget.month == day.month &&
                        (day == widget.today || day.compareTo(widget.today) == -1),
                    isToday: widget.today == day,
                    onTap: () {
                      widget.onDayChange(day);
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
