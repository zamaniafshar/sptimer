import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.onChange,
  }) : super(key: key);
  final void Function(int currentIndex) onChange;

  final models = const [
    CustomBottomNavigationBarItemModel(
      icon: Icons.home_outlined,
      alignment: Alignment.centerLeft,
      text: 'Home',
      index: 0,
    ),
    CustomBottomNavigationBarItemModel(
      icon: Icons.category_outlined,
      alignment: Alignment.centerRight,
      text: 'Status',
      index: 1,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.active) {
      controller.forward();
    } else {
      controller.reverse();
    }
    final theme = Theme.of(context);

    return Align(
      alignment: widget.model.alignment,
      child: InkWell(
        onTap: () {
          widget.onTap(widget.model.index);
        },
        borderRadius: BorderRadius.circular(15.r),
        child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? space) {
            final containerColor =
                Color.lerp(null, theme.primaryColor.withOpacity(0.2), controller.value);
            final textColor = Color.lerp(Colors.black, theme.primaryColorDark, controller.value);

            return Container(
              height: 45.h,
              width: 120.w,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                  space!,
                  Text(
                    widget.model.text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
          child: 10.horizontalSpace,
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
  });

  final IconData icon;
  final String text;
  final int index;
  final AlignmentGeometry alignment;
}
