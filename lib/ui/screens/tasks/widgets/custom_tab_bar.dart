import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/theme/app_colors.dart';
import 'package:pomotimer/utils/utils.dart';

class CustomTabBar extends StatelessWidget with PreferredSizeWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        gradient: [
          theme.primaryColorLight,
          theme.primaryColorDark,
        ].getLinearGradient,
        boxShadow: [
          BoxShadow(
            offset: const Offset(3, 3),
            blurRadius: 5,
            spreadRadius: 2,
            color: Colors.black26.withOpacity(0.2),
          ),
        ],
      ),
      child: TabBar(
        labelStyle: TextStyle(fontSize: 16.sp),
        unselectedLabelStyle: TextStyle(fontSize: 14.sp),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        labelPadding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white30,
        ),
        tabs: [
          TabBarLabel(
            label: 'All',
            suffix: '6',
          ),
          TabBarLabel(
            label: 'Done',
            suffix: '4',
          ),
          TabBarLabel(
            label: 'Remain',
            suffix: '2',
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(0, 50.h);
}

class TabBarLabel extends StatelessWidget {
  const TabBarLabel({
    Key? key,
    required this.label,
    required this.suffix,
  }) : super(key: key);

  final String label;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            strutStyle: StrutStyle.fromTextStyle(const TextStyle(fontSize: 16)),
          ),
          5.horizontalSpace,
          Container(
            width: 25.w,
            height: 25.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.white.withOpacity(0.3),
            ),
            child: Text(
              suffix,
              strutStyle: StrutStyle.fromTextStyle(const TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
