import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/config/localization/localization_cubit.dart';
import 'package:sptimer/config/theme/theme_cubit.dart';
import 'package:sptimer/screens/tasks/widgets/animated_theme_button.dart';
import 'package:sptimer/screens/tasks/widgets/tasks_tab_bar.dart';
import 'package:sptimer/common/extensions/extensions.dart';

class TasksAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TasksAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;

    return AppBar(
      title: Text(localization.tasksScreenTitle),
      bottom: const TasksTabBar(),
      actions: [
        Center(
          child: MaterialButton(
            onPressed: context.read<LocalizationCubit>().toggle,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            minWidth: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
            child: Row(
              children: [
                Icon(
                  Icons.language,
                  color: theme.primaryColorDark,
                ),
                3.horizontalSpace,
                Text(
                  context.read<LocalizationCubit>().state.languageCode,
                  style: theme.primaryTextTheme.labelMedium,
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: [
              theme.primaryColorLight,
              theme.primaryColorDark,
            ].getLinearGradient,
          ),
          child: AnimatedThemeButton(
            radius: 40.r,
            showMoonAtFirst: context.read<ThemeCubit>().state == ThemeState.dark,
            onChange: (value) {
              context.read<ThemeCubit>().toggle();
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
