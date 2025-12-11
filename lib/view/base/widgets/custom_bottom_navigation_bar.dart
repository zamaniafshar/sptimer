import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/common/extensions/extensions.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.onChange,
  }) : super(key: key);
  final void Function(int currentIndex) onChange;

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentIndex = 0;

  void onSelectedTapChanged(int index) {
    currentIndex = index;
    widget.onChange(currentIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;

    return BottomAppBar(
      color: theme.colorScheme.surfaceBright,
      elevation: 10,
      height: 65.h,
      shadowColor: Colors.black,
      shape: const CircularNotchedRectangle(),
      notchMargin: 12.r,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomBottomNavigationBarItem(
              icon: Icons.home,
              text: localization.baseScreenHome,
              index: 0,
              active: currentIndex == 0,
              onTap: onSelectedTapChanged,
            ),
            CustomBottomNavigationBarItem(
              icon: Icons.calendar_month_outlined,
              text: 'Calendar',
              index: 1,
              active: currentIndex == 1,
              onTap: onSelectedTapChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomNavigationBarItem extends StatefulWidget {
  const CustomBottomNavigationBarItem({
    super.key,
    required this.icon,
    required this.text,
    required this.index,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final int index;

  final bool active;
  final void Function(int index) onTap;

  @override
  State<CustomBottomNavigationBarItem> createState() => _CustomBottomNavigationBarItemState();
}

class _CustomBottomNavigationBarItemState extends State<CustomBottomNavigationBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: widget.active ? 1.0 : 0.0,
    );
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomBottomNavigationBarItem oldWidget) {
    if (widget.active) {
      controller.forward();
    } else {
      controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap(widget.index);
      },
      borderRadius: BorderRadius.circular(15.r),
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, _) {
          final containerColor = Color.lerp(
            null,
            theme.primaryColor.withOpacity(0.2),
            controller.value,
          );
          final textColor = Color.lerp(
            theme.textTheme.bodySmall!.color,
            theme.primaryColorDark,
            controller.value,
          );

          return Container(
            height: 40.h,
            width: 120.w,
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: textColor,
                  size: 27.r,
                ),
                5.horizontalSpace,
                Text(
                  widget.text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
