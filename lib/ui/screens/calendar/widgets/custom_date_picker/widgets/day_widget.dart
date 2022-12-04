import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayWidget extends StatelessWidget {
  const DayWidget({
    Key? key,
    required this.title,
    required this.day,
    required this.onTap,
    required this.width,
    required this.isSelected,
    required this.isActive,
    required this.isToday,
  }) : super(key: key);

  final String title;
  final String day;
  final VoidCallback onTap;
  final double width;
  final bool isSelected;
  final bool isActive;
  final bool isToday;

  List<Color> getContainerColors(ThemeData theme) {
    Color color1;
    Color color2;
    if (isSelected) {
      color2 = theme.colorScheme.secondary;
      color1 = theme.colorScheme.secondaryContainer;
    } else if (isToday) {
      color1 = theme.colorScheme.secondary;
      color2 = theme.colorScheme.secondaryContainer;
    } else {
      color1 = isActive ? theme.colorScheme.surface : Color(0xFFe7e7e7);
      color2 = isActive ? theme.backgroundColor : Color(0xFFe7e7e7);
    }
    return [color1, color2];
  }

  Color? getTextColor(ThemeData theme) {
    if (isToday || isSelected) {
      return Colors.white;
    } else if (isActive) {
      return null;
    } else {
      return Colors.black26;
    }
  }

  List<BoxShadow>? getShadow(ThemeData theme) {
    if (isActive) {
      return [
        BoxShadow(
          blurRadius: 3,
          spreadRadius: 1,
          color: Color.fromARGB(isSelected ? 12 : 24, 0, 0, 0),
          offset: const Offset(3, 3),
        ),
      ];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      color: getTextColor(theme),
    );
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: width,
        height: 60.h,
        padding: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: getContainerColors(theme),
          ),
          boxShadow: getShadow(theme),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              title,
              style: textStyle,
            ),
            Text(
              day,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
