import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pomotimer/localization/app_localization.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.onChange,
  }) : super(key: key);
  final void Function(int currentIndex) onChange;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTexts = AppLocalization.of(context);
    final models = [
      CustomBottomNavigationBarItemModel(
        icon: Icons.home_outlined,
        alignment: AlignmentDirectional.centerStart,
        text: appTexts.baseScreenHome,
        index: 0,
        height: 45.h,
        width: 110.w,
      ),
      CustomBottomNavigationBarItemModel(
        icon: Icons.calendar_month_outlined,
        alignment: AlignmentDirectional.centerEnd,
        text: appTexts.baseScreenCalendar,
        index: 1,
        height: 45.h,
        width: 120.w,
      ),
    ];
    return SizedBox(
      height: 70.h,
      child: BottomAppBar(
        color: theme.backgroundColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 12.r,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15.w),
          child: ValueBuilder<int?>(
            initialValue: 0,
            builder: (currentIndex, updater) {
              return Stack(
                children: models
                    .map(
                      (model) => CustomBottomNavigationBarItem(
                        model: model,
                        active: model.index == currentIndex,
                        onTap: (index) {
                          updater(index);
                          onChange(index);
                        },
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBarItem extends StatefulWidget {
  const CustomBottomNavigationBarItem({
    Key? key,
    required this.model,
    required this.active,
    required this.onTap,
  }) : super(key: key);
  final CustomBottomNavigationBarItemModel model;
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
    return Align(
      alignment: widget.model.alignment,
      child: InkWell(
        onTap: () {
          widget.onTap(widget.model.index);
        },
        borderRadius: BorderRadius.circular(15.r),
        child: AnimatedBuilder(
          animation: controller,
          child: 5.horizontalSpace,
          builder: (BuildContext context, Widget? child) {
            final containerColor =
                Color.lerp(null, theme.primaryColor.withOpacity(0.2), controller.value);
            final textColor = Color.lerp(
                theme.textTheme.bodySmall!.color, theme.primaryColorDark, controller.value);

            return Container(
              width: widget.model.width,
              height: widget.model.height,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.model.icon,
                    color: textColor,
                    size: 27.r,
                  ),
                  child!,
                  Text(
                    widget.model.text,
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
      ),
    );
  }
}

class CustomBottomNavigationBarItemModel {
  const CustomBottomNavigationBarItemModel({
    required this.icon,
    required this.text,
    required this.index,
    required this.alignment,
    this.height,
    this.width,
  });

  final IconData icon;
  final String text;
  final int index;
  final AlignmentGeometry alignment;
  final double? height;
  final double? width;
}
