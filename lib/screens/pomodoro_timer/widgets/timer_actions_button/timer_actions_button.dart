import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/data/enums/timer_status.dart';
import 'package:sptimer/logic/pomodoro_timer/pomodoro_timer_cubit.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/widgets/circle_neumorphic_button.dart';
import 'package:sptimer/screens/pomodoro_timer/widgets/timer_actions_button/custom_animated_icon.dart';

class TimerActionButtons extends StatelessWidget {
  const TimerActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: SizedBox(
        height: 100.h,
        width: 270,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            BlocSelector<PomodoroTimerCubit, PomodoroTimerState, TimerStatus>(
              selector: (state) => state.timerStatus,
              builder: (context, timerStatus) {
                return AnimatedAlign(
                  duration: const Duration(milliseconds: 500),
                  alignment: timerStatus.isFinished ? Alignment.center : Alignment.centerRight,
                  child: CircleNeumorphicButton(
                    showInnerNeumorphicShape: true,
                    radius: 75.r,
                    color: theme.colorScheme.surface,
                    onTap: context.read<PomodoroTimerCubit>().finish,
                    icon: Icon(
                      Icons.stop,
                      color: Colors.black54,
                      size: 50.r,
                    ),
                  ),
                );
              },
            ),
            BlocSelector<PomodoroTimerCubit, PomodoroTimerState, TimerStatus>(
              selector: (state) => state.timerStatus,
              builder: (context, timerStatus) {
                return AnimatedAlign(
                  duration: const Duration(milliseconds: 500),
                  alignment: timerStatus.isFinished ? Alignment.center : Alignment.centerLeft,
                  child: CircleNeumorphicButton(
                    radius: 75.r,
                    showInnerNeumorphicShape: true,
                    color: theme.colorScheme.surface,
                    onTap: context.read<PomodoroTimerCubit>().restart,
                    icon: AnimatedRotation(
                      duration: const Duration(milliseconds: 500),
                      turns: timerStatus.isFinished ? 0 : 2,
                      child: Icon(
                        Icons.refresh,
                        color: Colors.black54,
                        size: 50.r,
                      ),
                    ),
                  ),
                );
              },
            ),
            BlocSelector<PomodoroTimerCubit, PomodoroTimerState, TimerStatus>(
              selector: (state) => state.timerStatus,
              builder: (context, timerStatus) {
                return CircleNeumorphicButton(
                  radius: 100.r,
                  colors: [
                    theme.primaryColorLight,
                    theme.primaryColorDark,
                  ],
                  icon: AnimatedPlayPauseIcon(
                    showPlay: !timerStatus.isStarted,
                  ),
                  onTap: () {
                    final pomodoroTimer = context.read<PomodoroTimerCubit>();
                    final timerStatus = pomodoroTimer.state.timerStatus;

                    switch (timerStatus) {
                      case TimerStatus.started:
                        pomodoroTimer.pause();
                      case TimerStatus.paused:
                        pomodoroTimer.resume();
                      case TimerStatus.finished:
                        pomodoroTimer.start();
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
