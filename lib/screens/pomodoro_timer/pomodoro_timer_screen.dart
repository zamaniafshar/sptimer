import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/data/enums/pomodoro_status.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/logic/pomodoro_timer/pomodoro_timer_cubit.dart';
import 'package:sptimer/screens/pomodoro_timer/widgets/gradient_text.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'widgets/animated_text_style.dart';
import 'widgets/back_alert_dialog.dart';
import 'widgets/timer_actions_button/timer_actions_button.dart';
import 'widgets/countdown_timer/countdown_timer.dart';

class PomodoroTimerScreen extends StatefulWidget {
  const PomodoroTimerScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  State<PomodoroTimerScreen> createState() => _PomodoroTimerScreenState();
}

class _PomodoroTimerScreenState extends State<PomodoroTimerScreen> {
  @override
  void initState() {
    context.read<PomodoroTimerCubit>().start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      body: BlocBuilder<PomodoroTimerCubit, PomodoroTimerState>(
        builder: (context, state) {
          return AnimatedContainer(
            duration: const Duration(seconds: 1),
            padding: EdgeInsetsDirectional.fromSTEB(10.w, 10.h, 10.w, 20.h),
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [
                  !state.timerStatus.isFinished ? theme.cardColor : theme.colorScheme.surface,
                  theme.scaffoldBackgroundColor,
                ],
                stops: const [
                  0.1,
                  0.7,
                ],
              ),
            ),
            child: const _Body(),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  String getPomodoroText(BuildContext context, PomodoroTimerState state) {
    final localization = context.localization;
    final workMinutes = state.task.workDuration.inMinutes;
    final shortBreakMinutes = state.task.shortBreakDuration.inMinutes;
    final longBreakMinutes = state.task.longBreakDuration.inMinutes;

    return switch (state.pomodoroStatus) {
      PomodoroStatus.work => localization.workTimeDescription(workMinutes),
      PomodoroStatus.shortBreak => localization.shortBreakDescription(shortBreakMinutes),
      PomodoroStatus.longBreak => localization.longBreakDescription(longBreakMinutes),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _AppBar(),
          5.verticalSpace,
          CountdownTimer(),
          const SizedBox(),
          Container(
            alignment: AlignmentDirectional.center,
            height: 50.h,
            child: BlocBuilder<PomodoroTimerCubit, PomodoroTimerState>(
              builder: (context, state) {
                return GradientText(
                  colors: [
                    theme.primaryColorLight,
                    theme.primaryColorDark,
                  ],
                  text: AnimatedTextStyle(
                    text: getPomodoroText(context, state),
                    textStyle: const TextStyle(fontSize: 0, inherit: false),
                    secondTextStyle: theme.primaryTextTheme.bodyLarge!,
                  ),
                );
              },
            ),
          ),
          TimerActionButtons(),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AppBar(
      backgroundColor: Colors.transparent,
      title: BlocBuilder<PomodoroTimerCubit, PomodoroTimerState>(
        builder: (context, state) {
          return Text(
            state.task.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
            overflow: TextOverflow.ellipsis,
          );
        },
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: 27.r,
        ),
        onPressed: () {
          final pomodoroTimer = context.read<PomodoroTimerCubit>();
          final pomodoroState = pomodoroTimer.state;
          if (pomodoroState.timerStatus.isFinished) return Navigator.pop(context);

          showBackAlertDialog(
            context,
            onContinue: () {
              Navigator.pop(context);
            },
            onCancel: () {
              pomodoroTimer.finish();
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
