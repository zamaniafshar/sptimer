import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/config/localization/localization_cubit.dart';
import 'package:sptimer/config/theme/theme_cubit.dart';
import 'package:sptimer/screens/tasks/widgets/animated_theme_button.dart';
import 'package:sptimer/screens/tasks/widgets/tasks_app_bar.dart';
import 'package:sptimer/common/extensions/extensions.dart';

import 'widgets/tasks_tab_bar_view.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TasksAppBar(),
        body: TasksTabBarView(),
      ),
    );
  }
}
